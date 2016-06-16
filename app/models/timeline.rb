class Timeline
  # in test env, change the name of the set to something else
  NAME_OF_SET = self.class.name

  def self.index name=NAME_OF_SET
    self._index Tweet do |i|
      i.posted_at
    end
    self._index InstagramPost do |i|
      i.posted_at
    end
    return nil
  end

  def self.clear
    $redis.zremrangebyrank(NAME_OF_SET, 0, -1)
  end

  def self.all name=NAME_OF_SET
    gids = $redis.zrevrange(NAME_OF_SET, 0, -1)
    gids.map do |gid|
      GlobalID::Locator.locate gid
    end
  end

  private
  def self._index model_class, &block
    model_class.all.each do |instance|
      time = yield instance
      $redis.zadd(NAME_OF_SET, time.to_i, instance.to_global_id.to_s)
    end
  end
end
