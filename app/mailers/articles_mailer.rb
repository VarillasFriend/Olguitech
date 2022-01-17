# frozen_string_literal: true

class ArticlesMailer < ApplicationMailer
    def article(user, article)
        @user = user

        @user.regenerate_newsletter_token if @user.newsletter_token.nil?

        @token = @user.newsletter_token
        @article = article

        model_name = @article.model_name.singular
        human = @article.model_name.human
        subject = "#{model_name == 'article' ? t('mail.articles.subject.new1') : t('mail.articles.subject.new2')}\
 #{human} #{t('mail.articles.subject.from')} Olguitech!"

        I18n.with_locale(@user.locale) do
            mail(to: @user.email, subject: subject)
        end
    end
end
