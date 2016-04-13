require 'net/http'
require 'json'
class Message

  END_POINT_HOST="trialbot-api.line.me"
  PATH="/v1/events"
  PORT=443

  def post_text_message(to_mid, message)
    data={to:[to_mid],
        toChannel:1383378250,
        eventType:"138311608800106203",
        content:{
          contentType:1,
          toType:1,
          text:message
        }
    }.to_json
    request = Net::HTTP::Post.new(PATH, initheader={'Content-Type':'application/json; charset=UTF-8'})
    request.add_field 'X-Line-ChannelID', LineBot::Channel::ID
    request.add_field 'X-Line-ChannelSecret', LineBot::Channel::SECRET
    request.add_field 'X-Line-Trusted-User-With-ACL', LineBot::Channel::MID

    http = Net::HTTP.new(END_POINT_HOST, PORT)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http.set_debug_output $stderr
    http.start {|h|
     response = h.request(request, data)
     if response.code == '200'
       res_body = response.body
       return res_body
     end
    }
 end
end

