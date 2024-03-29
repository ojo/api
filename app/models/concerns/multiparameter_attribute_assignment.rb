# app/models/concerns/multiparameter_attribute_assignment.rb

module MultiparameterAttributeAssignment
  include ActiveModel::ForbiddenAttributesProtection

  def initialize(params = {})
    assign_attributes(params)
  end

  def assign_attributes(new_attributes)
    multi_parameter_attributes  = []

    attributes = sanitize_for_mass_assignment(new_attributes.stringify_keys)

    attributes.each do |k, v|
      if k.include?('(')
        multi_parameter_attributes << [ k, v ]
      else
        send("#{k}=", v)
      end
    end

    assign_multiparameter_attributes(multi_parameter_attributes) unless multi_parameter_attributes.empty?
  end

  alias attributes= assign_attributes

  protected

  def attribute_assignment_error_class
    ActiveModel::AttributeAssignmentError
  end

  def multiparameter_assignment_errors_class
    ActiveModel::MultiparameterAssignmentErrors
  end

  def unknown_attribute_error_class
    ActiveModel::UnknownAttributeError
  end

  def assign_multiparameter_attributes(pairs)
    execute_callstack_for_multiparameter_attributes(
        extract_callstack_for_multiparameter_attributes(pairs)
    )
  end

  def execute_callstack_for_multiparameter_attributes(callstack)
    errors = []

    callstack.each do |name, values_with_empty_parameters|
      begin
        raise unknown_attribute_error_class, "unknown attribute: #{name}" unless respond_to?("#{name}=")
        send("#{name}=", MultiparameterAttribute.new(self, name, values_with_empty_parameters).read_value)
      rescue => ex
        errors << attribute_assignment_error_class.new("error on assignment #{values_with_empty_parameters.values.inspect} to #{name} (#{ex.message})", ex, name)
      end
    end

    unless errors.empty?
      error_descriptions = errors.map { |ex| ex.message }.join(',')
      raise multiparameter_assignment_errors_class.new(errors), "#{errors.size} error(s) on assignment of multiparameter attributes [#{error_descriptions}]"
    end
  end

  def extract_callstack_for_multiparameter_attributes(pairs)
    attributes = {}

    pairs.each do |(multiparameter_name, value)|
      attribute_name = multiparameter_name.split('(').first
      attributes[attribute_name] ||= {}

      parameter_value = value.empty? ? nil : type_cast_attribute_value(multiparameter_name, value)
      attributes[attribute_name][find_parameter_position(multiparameter_name)] ||= parameter_value
    end

    attributes
  end

  def type_cast_attribute_value(multiparameter_name, value)
    multiparameter_name =~ /\([0-9]*([if])\)/ ? value.send("to_#{$1}") : value
  end

  def find_parameter_position(multiparameter_name)
    multiparameter_name.scan(/\(([0-9]*).*\)/).first.first.to_i
  end
end

class MultiparameterAttribute
  attr_reader :object, :name, :values

  def initialize(object, name, values)
    @object = object
    @name   = name
    @values = values
  end

  def class_for_attribute
    object.class_for_attribute(name)
  end

  def read_value
    return if values.values.compact.empty?

    klass = class_for_attribute

    if klass.nil?
      raise ActiveModel::UnexpectedMultiparameterValueError,
            "Did not expect a multiparameter value for #{name}. " +
                'You may be passing the wrong value, or you need to modify ' +
                'class_for_attribute so that it returns the right class for ' +
                "#{name}."
    elsif klass == Time
      read_time
    elsif klass == Date
      read_date
    else
      read_other(klass)
    end
  end

  private

  def instantiate_time_object(set_values)
    Time.zone.local(*set_values)
  end

  def read_time
    validate_required_parameters!([1,2,3])
    return if blank_date_parameter?

    max_position = extract_max_param(6)
    set_values   = values.values_at(*(1..max_position))
    # If Time bits are not there, then default to 0
    (3..5).each { |i| set_values[i] = set_values[i].presence || 0 }
    instantiate_time_object(set_values)
  end

  def read_date
    return if blank_date_parameter?
    set_values = values.values_at(1,2,3)

    begin
      Date.new(*set_values)
    rescue ArgumentError # if Date.new raises an exception on an invalid date
      instantiate_time_object(set_values).to_date # we instantiate Time object and convert it back to a date thus using Time's logic in handling invalid dates
    end
  end

  def read_other(klass)
    max_position = extract_max_param
    positions    = (1..max_position)
    validate_required_parameters!(positions)

    set_values = values.values_at(*positions)
    klass.new(*set_values)
  end

  def blank_date_parameter?
    (1..3).any? { |position| values[position].blank? }
  end

  def validate_required_parameters!(positions)
    if missing_parameter = positions.detect { |position| !values.key?(position) }
      raise ArgumentError.new("Missing Parameter - #{name}(#{missing_parameter})")
    end
  end

  def extract_max_param(upper_cap = 100)
    [values.keys.max, upper_cap].min
  end
end

class ActiveModel::AttributeAssignmentError < StandardError
  attr_reader :exception, :attribute

  def initialize(message, exception, attribute)
    super(message)
    @exception = exception
    @attribute = attribute
  end
end

class ActiveModel::MultiparameterAssignmentErrors < StandardError
  attr_reader :errors

  def initialize(errors)
    @errors = errors
  end
end

class ActiveModel::UnexpectedMultiparameterValueError < StandardError
end

class ActiveModel::UnknownAttributeError < NoMethodError
end
