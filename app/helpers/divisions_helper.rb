module DivisionsHelper
  def difference(value)
    if value > 0
      "&uarr; #{value}".html_safe
    elsif value == 0
    "#{value}"
    else
      "&darr; #{value}".html_safe
    end
  end
end
