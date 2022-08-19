class LinebotController < ApplicationController  
  require 'line/bot'  

  def client  
    @client ||= Line::Bot::Client.new { |config|  
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]  
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]  
    }  
  end  

  def push
    message={
        type: 'text',
        text: "hello"   
    }
    user_id =  'U072ae1c1843f9f2554e9949cd3d8522a'
    response = client.push_message(user_id, message)
  end

end  