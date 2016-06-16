class Timeline
  # in test env, change the name of the set to something else
  REDIS_ZSET_PREFIX = self.class.name
  REDIS_INDEX_KEY = "#{self.class.name}-live-index"

  def self.index
    clear_offline_index

    self._index_offline Tweet.published do |i|
      i.posted_at
    end
    self._index_offline InstagramPost.published do |i|
      i.posted_at
    end

    swap_indices
  end

  def self.clear
    $redis.zremrangebyrank(name_of_offline_index, 0, -1)
    $redis.zremrangebyrank(name_of_live_index, 0, -1)
  end

  def self.all
    gids = $redis.zrevrange(name_of_live_index, 0, -1)
    gids.map do |gid|
      GlobalID::Locator.locate gid
    end
  end

  private

  def self.swap_indices
    curr = $redis.get(REDIS_INDEX_KEY)
    $redis.set(REDIS_INDEX_KEY, next_index(curr))
  end

  def self.clear_offline_index
    $redis.zremrangebyrank(name_of_offline_index, 0, -1)
  end

  def self.name_of_live_index
    curr = $redis.get(REDIS_INDEX_KEY)
    "#{REDIS_ZSET_PREFIX}-#{curr}"
  end

  def self.name_of_offline_index
    curr = $redis.get(REDIS_INDEX_KEY)
    "#{REDIS_ZSET_PREFIX}-#{next_index(curr)}"
  end

  def self.next_index curr
    { A: 'B', B: 'A' }[curr]
  end

  def self._index_offline active_record_relation, &block
    index = name_of_offline_index

    active_record_relation.all.each do |instance|
      time = yield instance
      $redis.zadd(index, time.to_i, instance.to_global_id.to_s)
    end
  end
end
