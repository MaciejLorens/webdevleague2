module DivisionsHelper
  def difference(value)
    if value > 0
      "&uarr; #{value}".html_safe
    elsif value == 0
    "#{value}".html_safe
    else
      "&darr; #{value}".html_safe
    end
  end
end
