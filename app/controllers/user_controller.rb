class UserController < ApplicationController
  @user.avatar.attach(io: File.open('app/assets/images/placeholder.png'),
    filename: 'placeholder.png', content_type: 'image/png')
end
