# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview
    # Preview this email at http://localhost:3000/rails/mailers/contact_mailer/contacto
    def contacto
        user = User.last
        contact = user.contactos.new(message: 'saddsa')
        contact.interests.new(record_type: 'Article', record_id: Article.last.id)
        contact.interests.new(record_type: 'Article', record_id: Article.last.id)

        ContactMailer.contacto(user, contact)
    end

    # Preview this email at http://localhost:3000/rails/mailers/contact_mailer/admin_contacto
    def admin_contacto
        user = User.last
        contact = user.contactos.new(message: 'saddsa')
        contact.interests.new(record_type: 'Article', record_id: Article.last.id)
        contact.interests.new(record_type: 'Article', record_id: Article.last.id)

        ContactMailer.admin_contacto(user, contact)
    end
end
