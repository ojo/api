require 'test_helper'

class NewsItemTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper

  test "count" do
    assert 1, NewsItem.count
  end
  test "if there's an image, we compute dominant color" do
    news_item = news_items(:basic)
    perform_enqueued_jobs do
      img_path = Rails.root.join("test/fixtures/files/test.png")
      news_item.photo = File.new img_path
      news_item.save!
    end

    news_item.reload
    assert news_item.photo_dominant_color != nil
  end
end
