require "test_helper"

class ComputeDominantColorJobTest < ActiveSupport::TestCase
  test "foo" do
    obj = news_items(:basic)
    obj.photo = File.new Rails.root.join("test/fixtures/files/test.png")
    obj.save!
    ComputeDominantColorJob.new.perform(obj, 'photo', 'photo_dominant_color')
    obj.reload
    assert obj.photo_dominant_color != nil
  end
end
