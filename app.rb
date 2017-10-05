require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

configure do
  enable :sessions
end

helpers do
  def username
    session[:identity] ? session[:identity] : 'Hello stranger'
  end
end


get '/' do
   erb 'Can you handle a <a href="/secure/place">secret</a>?'
end



post '/visit' do
  @list = params[:list]
  @username = params[:user_name]
  @namber_phone = params[:namber_phone]
  @data_time = params[:data_time]
  @color = params[:color]

  f = File.open './public/user.txt','a'
  f.write "User:#{@username}, Phone:#{@namber_phone}, Data:#{@data_time}, Hairdresser:#{@list}, Color: #{@color}. "
  f.close

  erb 'Спасибо!! ждем вас'
end

post '/contacts' do
  @Email1 = params[:Email1]
  @Message = params[:Message]

  if @Email1 == '' 
     erb 'Поле Email не должно быть пустым'
  else

     f = File.open './public/contacts.txt','a'
     f.write "Contacts: #{@Email1}, Message: #{@Message}. "
     f.close

     erb 'Мы сохранили ваш контакт и сообщение!!! <a href="/contacts">Contacts</a>?'
  end
end


get '/about' do
  @error = 'Ошибка!!!!'
  erb :about
end

get '/visit' do
  erb :visit  
end

get '/contacts' do
  erb :contacts
end

get '/login/form' do
  erb :login_form
end

post '/login/form' do
  @Email2 = params[:Email2]
  @Password2 = params[:Password2]

  if @Email2 == 'admin@mail.ru' && @Password2 == '123456'
          erb 'Добрый день Админ'
    else
          erb 'Проверьте логин и пароль'
  end

end