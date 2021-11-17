# frozen_string_literal: true

def get_messages_lists(channel_names)
  messages_lists =
    channel_names.map { |channel_name| load(channel_name)['messages'] }
  messages_lists.flatten
end
