
class Bot

  module CONTENT_TYPE
    TEXT=1
    IMAGE=2
    VIDEO=3
    AUDIO=4
    LOCATION=7
    STICKER=8
    CONTACT=10
  end
  include CONTENT_TYPE

  def self.responce(data)
    content = data['content']
    from = content['from']

    case content['contentType']
      when TEXT
        text = "「#{content['text']}」って何？"
      when IMAGE
        text = "これは何の写真？"
      when VIDEO
        text = "これは何のビデオ？"
      when AUDIO
        text = "これは何の音？"
      when LOCATION
        text = "これはどこ？"
      when
        text = "スタンプ ありがとう！"
      else
    end
    Message.new.post_text_message(from, text)
  end
end