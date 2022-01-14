class Article < ApplicationRecord
    include Getters

    extend FriendlyId
    friendly_id :title, use: :slugged

    has_rich_text :content
    has_rich_text :content2
    has_one_attached :image

    has_many :product_referenceables, as: :referenceable, dependent: :destroy
    has_many :products, through: :product_referenceables, as: :referenceable

    has_many :category_categorizables, as: :categorizable, dependent: :destroy
    has_many :categories, through: :category_categorizables, as: :categorizable

    def base_uri
        Rails.application.routes.url_helpers.article_path(self, locale: I18n.locale)
    end
end
