module ApplicationHelper

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

end
