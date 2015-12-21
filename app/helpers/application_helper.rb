module ApplicationHelper

  def default_price(dollars: false)
    if dollars
      Setting.first.default_price_in_dollars
    else
      Setting.first.default_price
    end
  end

  def calculate_price(item, dollars: false)
    if dollars
      item.custom_price_in_dollars || Setting.first.default_price_in_dollars
    else
      item.custom_price || Setting.first.default_price
    end
  end

  def calculate_subtotal(cart, dollars: false)
    if dollars
      price = Setting.first.default_price_in_dollars
      cart.line_items.to_a.sum { |item| item.custom_price_in_dollars || price }
    else
      price = Setting.first.default_price
      cart.line_items.to_a.sum { |item| item.custom_price || price }
    end
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
