module Admin::SocialmediaHelper

  def form_for_published_toggle entity
    model = entity.is_a?(Array) ? entity.last : entity
    param = :published
    if model.send(param)
      return form_for_toggle entity, param, false, 'Unpublish'
    end
    form_for_toggle entity, param, true, 'Publish'
  end

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
