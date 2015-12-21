module ApplicationHelper

  def default_price
    Setting.first.default_price
  end

  def options_for_license
    ["Web Editorial", "Print", "Web and Print"]
  end

  def options_for_nationality
    ["National", "International"]
  end

  def vip_list(what)
    what.vips.map(&:name).join(', ')
  end

  def date_of_event(event)
    event.date.strftime("%a, %b %d %Y ")
  end

  def css_class_active_for link_path
    link_path == request.env['PATH_INFO'] ? "active" : "inactive"
  end

end
