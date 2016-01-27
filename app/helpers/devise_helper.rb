module DeviseHelper
  def devise_error_messages!
    return '' if resource.errors.empty?

    flash[:error] = resource.errors.full_messages.join("; ")

    return ''
  end
end