# frozen_string_literal: true

require 'json'

class HighMotivationUserAggregator
  attr_accessor :channel_names

  def initialize(channel_names)
    @channel_names = channel_names
  end

  # 実装してください
  def exec
    channel_messages_count_lists =
      get_channel_messages_count_lists(@channel_names)

    sort_lists(channel_messages_count_lists).first(3)
  end

  def get_channel_messages_count_lists(channel_names)
    channel_messages_count_lists = []
    channel_names.each do |channel_name|
      count = load(channel_name)['messages'].count
      channel_messages_count_lists.push(
        { channel_name: channel_name, message_count: count },
      )
    end
    channel_messages_count_lists
  end

  def sort_lists(lists)
    lists.sort { |a, b| b[:message_count] <=> a[:message_count] }
  end

  def load(channel_name)
    dir = File.expand_path("../data/#{channel_name}", File.dirname(__FILE__))
    file = File.open(dir)
    JSON.load(file)
  end
end
