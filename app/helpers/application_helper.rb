module ApplicationHelper

  def errors_form_for(record, options = {}, &proc)
    form_for(record, options.merge!({builder: ErrorsFormBuilder}), &proc)
  end

end
