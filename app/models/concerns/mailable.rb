# frozen_string_literal: true

module Mailable
    def send_mail
        update(newsletter_sent: true)

        User.all.where(newsletter: true).each do |user|
            ArticlesMailer.article(user, self).deliver_later
        end
    end
end
