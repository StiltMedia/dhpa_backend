module ApplicationHelper

  def default_personal_or_commercial_price(item, dollars=false)
    if item.delivery_option.license == "Commercial Use"
      default_commercial_price(dollars)
    elsif item.delivery_option.license == "Personal Use"
      default_personal_price(dollars)
    else
      return nil
    end
  end

  def default_commercial_price(dollars=false)
    if dollars
      Setting.first.commercial_price_in_dollars
    else
      Setting.first.commercial_price
    end
  end

  def default_personal_price(dollars=false)
    if dollars
      Setting.first.personal_price_in_dollars
    else
      Setting.first.personal_price
    end
  end

  def personal_image_size
    Setting.first.personal_image_size
  end

  def display_size(item)
    personal_size = calculate_personal_size(item.photo.size)
    if personal_size != item.is_personal?
      personal_size
    else
      photo.size
    end
  end

  def display_size_list(photo)
    personal_size = calculate_personal_size(photo.size)
    if personal_size != photo.size
      "#{photo.size} commercial, #{personal_size} personal"
    else
      "#{photo.size} commercial & personal"
    end
  end

  def calculate_personal_size(size)
    split = size.split("x")
    if split.length == 2
      parsed = split.map(&:to_f)
      max_size = personal_image_size.to_f
      if parsed.first > max_size || parsed.last > max_size
        # Size is the smaller dimension scaled down by the ratio of the max size to the larger dimension, and the max size
        if parsed.first > parsed.last
          "#{max_size.round}x#{(max_size/parsed.first*parsed.last).round}"
        else
          "#{(max_size/parsed.last*parsed.first).round}x#{max_size.round}"
        end
      else
        size # Nothing to do, image not larger
      end
    end
  end

  def calculate_price(item, dollars=false)
    if dollars
      item.custom_price_in_dollars || default_personal_or_commercial_price(item, dollars)
    else
      item.custom_price || default_personal_or_commercial_price(item, dollars)
    end
  end

  def calculate_subtotal(cart_or_order, dollars=false)
    if dollars
      cart_or_order.line_items.to_a.sum do |item|
        item.custom_price_in_dollars || default_personal_or_commercial_price(item, dollars)
      end
    else
      cart_or_order.line_items.to_a.sum do |item|
        item.custom_price || default_personal_or_commercial_price(item, dollars)
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
