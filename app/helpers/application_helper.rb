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

  def default_meta_tags
    {
      site: 'debukatsu',
      title: 'デブかつApp',
      reverse: true,
      separator: '|',
      description: 'デブかつAppは忙しい社会人やお金のない学生に向けた太るためのサービスです。',
      keywords: '太る, カロリー, 社会人, 学生',
      canonical: 'https://www.debukatsu.net/',
      noindex: !Rails.env.production?,
      icon: image_url('favicon.ico'),
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: 'https://www.debukatsu.net/',
        image: image_url('site_logo.jpg'),
        locale: 'ja_JP',
      },
      twitter: {
        card: 'summary_large_image',
      }
    }
  end
end
