require 'test_helper'

class NewsMailerTest < ActionMailer::TestCase
    setup do 
        @user = users(:one)
    end

    test 'newsletter' do
        mail = NewsMailer.newsletter(@user, "Hello", "<div> HI </div>", "A subject")

        assert_equal 'A subject', mail.subject
        assert_equal [@user.email], mail.to
        assert_equal [ENV['EMAIL_USERNAME']], mail.from
        assert_match "Hello", mail.body.encoded
        assert_match "HI", mail.body.encoded
        assert_match @user.newsletter_token, mail.body.encoded
    end
end

# def newsletter(user, title, content, subject)
#     @user = user

#     @user.regenerate_newsletter_token if @user.newsletter_token == nil

#     @token = @user.newsletter_token
#     @title = title
#     @content = content
#     @subject = subject

#     mail(to: @user.email, subject: @subject)
# end