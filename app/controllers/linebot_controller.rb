class LinebotController < ApplicationController  
  require 'line/bot'  

  def self.client  
    @client ||= Line::Bot::Client.new { |config|  
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]  
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]  
    }  
  end  

  def self.push(reservation)
    message={
        type: 'text',
        text: "新規予約が入りました。
        #{reservation.user.kanji_last_name} #{reservation.user.kanji_first_name} 様
        #{reservation.reservation_date.strftime('%-m月%-d日')}
        #{reservation.reservation_time.strftime('%H:%M')}
        #{reservation.people_number}人"
    }
    user_id =  'U072ae1c1843f9f2554e9949cd3d8522a'
    response = client.push_message(user_id, message)
  end

  def self.cancel_push(reservation)
    message={
        type: 'text',
        text: "予約がキャンセルされました。
        #{reservation.user.kanji_last_name} #{reservation.user.kanji_first_name} 様
        #{reservation.reservation_date.strftime('%-m月%-d日')}
        #{reservation.reservation_time.strftime('%H:%M')}
        #{reservation.people_number}人"
    }
    user_id =  'U072ae1c1843f9f2554e9949cd3d8522a'
    response = client.push_message(user_id, message)
  end

end  