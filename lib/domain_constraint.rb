class DomainConstraint
  def initialize(domains)
    @domains = [domains].flatten
  end

  def matches? request
    @domains.include? request.host
  end
end
