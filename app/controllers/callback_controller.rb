class CallbackController < ApplicationController
  protect_from_forgery with: :null_session

  # Line Serverからのコールバックを受ける。
  # やっていることはただのオウム返し。
  #
  # ホントはこのアクションではキューに格納するだけにして、
  # 別途Workerプロセスで処理すべき。
  def recieve
    data_list = params[:result]
    data_list.each do |data|
      from = data['content']['from']
      text = data['content']['text']
      Message.new.post_text_message(from, text)
    end
    render status:200, text:'success'
  end
end
