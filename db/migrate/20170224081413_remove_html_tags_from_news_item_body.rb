class RemoveHtmlTagsFromNewsItemBody < ActiveRecord::Migration[5.0]
  def change
    NewsItem.all.each do |item|
      stripped = Rails::Html::FullSanitizer.new.sanitize item.body
      item.body = stripped
      item.save
    end
  end
end
