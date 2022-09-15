# frozen_string_literal: true

# class InviteMailer
class InviteMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def send_invitation(user, password)
    @user = user
    @password = password

    mail(to: @user.email, subject: 'Invi')
  end
end
