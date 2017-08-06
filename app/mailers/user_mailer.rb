class UserMailer < ActionMailer::Base
  def feedback(message)
    @message = message
    mail to: "feedback@chondi.net", from: @message.email, subject: "chondi Feedback from #{@message.name}"
  end

  def comment_response(comment, user)
    @comment = comment
    @user = user
    mail :to => @user.email, :from => "noreply@chondi.net", :subject => "Comment Response on RailsCasts"
  end
end
