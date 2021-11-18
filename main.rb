# frozen_string_literal: true

require_relative './lib/common'
require_relative './aggregator/high_motivation_user_aggregator'
require_relative './aggregator/kind_user_aggregator'
require_relative './aggregator/poupular_message_aggregator'

# 実際はファイル名ですが便宜上チャンネル名という変数名とする
channel_names = %w[
  times_makotokonishi.json
  times_gen.json
  times_taishiro.json
  times_miketa.json
  times_halki.json
  sparta_course.json
]

# 一番発信数が多いチャンネル ベスト3
# @param  ["times_makotokonishi.json", "times_gen.json", "times_taishiro.json", "times_miketa.json", "times_halki.json", "sparta_course.json"]
# @return [{:channel_name=>"●●●.json", :message_count=>●●●}, {:channel_name=>"●●●.json", :message_count=>●●●}, {:channel_name=>"●●●.json", :message_count=>●●●}]]
p HighMotivationUserAggregator.new(channel_names).exec

# 一番スタンプを押してるユーザー
# @param  ["times_makotokonishi.json", "times_gen.json", "times_taishiro.json", "times_miketa.json", "times_halki.json", "sparta_course.json"]
# @return [{:user_id=>"U●●●●●●", :reaction_count=>●●}, {:user_id=>"U●●●●●●", :reaction_count=>●●}, {:user_id=>"U●●●●●●", :reaction_count=>●●}]
p KindUserAggregator.new(channel_names).exec

# 一番スタンプを取得した投稿
# @param  ["times_makotokonishi.json", "times_gen.json", "times_taishiro.json", "times_miketa.json", "times_halki.json", "sparta_course.json"]
# @return {:text=>"●●●●●●●●●●●●●●●●●●●", :reaction_count=>●●}
p PopularMessageAggregator.new(channel_names).exec
