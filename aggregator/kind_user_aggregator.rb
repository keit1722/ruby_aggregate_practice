# frozen_string_literal: true

require 'json'

class KindUserAggregator
  attr_accessor :channel_names

  def initialize(channel_names)
    @channel_names = channel_names
  end

  # 実装してください
  def exec
    reacted_message_lists =
      get_reacted_message_lists(get_messages_lists(@channel_names))
    users_reacted = get_users_reacted(reacted_message_lists)
    count_users_reacted = get_count_users_reacted(users_reacted)
    top_user_reacted(arrange_hash(count_users_reacted))
  end

  def get_reacted_message_lists(lists)
    lists.select { |message| message.key?('reactions') }
  end

  def get_users_reacted(lists)
    reactions_lists = []
    lists.each do |list|
      list['reactions'].each do |reaction|
        reactions_lists.push(reaction['users'])
      end
    end
    reactions_lists.flatten
  end

  def get_count_users_reacted(users)
    reactions_count = users.group_by(&:itself).transform_values(&:size)
    reactions_count.sort_by { |_, v| -v }.to_h
  end

  def arrange_hash(hash)
    hash.map { |key, value| [user_id: key, reaction_count: value] }.flatten
  end

  def top_user_reacted(users)
    top_user_reacted = users.first(3)
  end

  def load(channel_name)
    dir = File.expand_path("../data/#{channel_name}", File.dirname(__FILE__))
    file = File.open(dir)
    JSON.load(file)
  end
end
