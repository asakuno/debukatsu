module FlashMessageHelper
  def flash_class(level)
    case level
      when 'notice' then 'bg-blue-100 border-t-4 border-blue-500 text-blue-900'
      when 'success' then 'bg-green-100 border-t-4 border-green-400 text-green-700'
      when 'danger' then 'bg-red-100 border-t-4 border-red-400 text-red-700'
      when 'alert' then 'bg-yellow-100 border-t-4 border-yellow-500 text-yellow-700'
    end
  end

  def flash_icon(img)
    case img
      when 'notice' then content_tag :i, '', class: 'fa-light fa-circle-info', style: 'color: #293f66;'
      when 'success' then content_tag :i, '', class: 'far fa-check-circle fa-lg', style: 'color: #31b441;'
      when 'danger' then content_tag :i, '', class: 'far fa-times-circle fa-lg', style: 'color: #e60000;'
      when 'alert' then content_tag :i, '', class: 'fal fa-exclamation fa-lg', style: 'color: #f78708;'
    end
  end
end
