# frozen_string_literal: true

module ApplicationHelper
  def sort_by_sort_url(url, order)
    uri = URI.parse(url)
    query_hash = URI.decode_www_form(uri.query).to_h
    query_hash[:s] = order
    uri.query = URI.encode_www_form(query_hash)
    uri.to_s
  end

  def page_title(page_title = '')
    base_title = 'デブかつApp'

    page_title.empty? ? base_title : page_title + ' - ' + base_title
  end
end
