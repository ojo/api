module Admin::SocialmediaHelper
  def form_for_toggle model, parameter, value, message
    class_for_value = value ? 'btn-info' : 'btn-success'
    capture do
      form_for model do |f|
        concat f.hidden_field parameter, value: value
        concat f.submit message, class: "btn #{ class_for_value }"
      end
    end
  end
end
