# frozen_string_literal: true

def get_messages_lists(channel_names)
  messages_lists = []
  channel_names.each do |channel_name|
    messages = load(channel_name)['messages']
    messages_lists.push(messages)
  end
  messages_lists.flatten
end
