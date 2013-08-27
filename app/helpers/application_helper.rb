module ApplicationHelper

  def errors_form_for(record, options = {}, &proc)
    form_for(record, options.merge!({builder: ErrorsFormBuilder}), &proc)
  end

  def options_for_ratings(selected=nil)
    options_for_select((1..5).map {|number| [pluralize(number, "Star"), number]}, selected)
  end
end
