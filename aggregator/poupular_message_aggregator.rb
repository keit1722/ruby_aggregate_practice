# frozen_string_literal: true

class PopularMessageAggregator
  attr_accessor :channel_names

  def initialize(channel_names)
    @channel_names = channel_names
  end

  # 実装してください
  def exec
    reacted_message_lists =
      get_reacted_message_lists(get_messages_lists(@channel_names))
    reaction_count_lists = count_reactions(reacted_message_lists)
    reactions = sort_reactions(reaction_count_lists)
    top_reactions_count(reactions)
  end

  def get_reacted_message_lists(lists)
    lists.select { |message| message.key?('reactions') }
  end

  def count_reactions(lists)
    reactions_count_list = []
    lists.each do |list|
      reactions_count = {}
      reactions_count[:text] = list['text']
      reactions_count_list.push(reactions_count)

      list['reactions'].each do |reaction|
        if reactions_count.key?(:reaction_count)
          reactions_count[:reaction_count] += reaction['count']
        else
          reactions_count[:reaction_count] = reaction['count']
        end
      end
    end
    reactions_count_list
  end

  def sort_reactions(lists)
    lists.sort { |a, b| a[:reaction_count] <=> b[:reaction_count] }.reverse
  end

  def top_reactions_count(iii)
    iii[0]
  end

  def load(channel_name)
    dir = File.expand_path("../data/#{channel_name}", File.dirname(__FILE__))
    file = File.open(dir)
    JSON.load(file)
  end
end
