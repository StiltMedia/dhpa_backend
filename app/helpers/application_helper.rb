module ApplicationHelper

  def return_personal_or_commercial_price(item, dollars=false)
    if item.delivery_option.license == "Commercial Use"
      commercial_price(dollars)
    elsif item.delivery_option.license == "Personal Use"
      personal_price(dollars)
    else
      return nil
    end
  end

  def commercial_price(dollars=false)
    if dollars
      Setting.first.commercial_price_in_dollars
    else
      Setting.first.commercial_price
    end
  end

  def personal_price(dollars=false)
    if dollars
      Setting.first.personal_price_in_dollars
    else
      Setting.first.personal_price
    end
  end

  def calculate_price(item, dollars=false)
    if dollars
      item.custom_price_in_dollars || return_personal_or_commercial_price(item, dollars)
    else
      item.custom_price || return_personal_or_commercial_price(item, dollars)
    end
  end

  def calculate_subtotal(cart, dollars=false)
    if dollars
      cart.line_items.to_a.sum do |item|
        item.custom_price_in_dollars || return_personal_or_commercial_price(item, dollars)
      end
    else
      cart.line_items.to_a.sum do |item|
        item.custom_price || return_personal_or_commercial_price(item, dollars)
      end
    end
  end

  def options_for_license
    ["Commercial Use", "Personal Use"]
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
