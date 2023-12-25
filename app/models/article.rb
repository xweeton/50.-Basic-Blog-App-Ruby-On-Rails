class Article < ApplicationRecord
    # pg_search
    include PgSearch::Model
    pg_search_scope :search_by_title_and_body, against: [:title, :body]
    # to allow attach image when create article
    has_one_attached :image
    # to allow use Action Text in body
    has_rich_text :body
    # status
    include Visible
    # one to many, and enable to see comments in article by 'article.comments', no need extra javascript code
    # dependent: :destroy, when delete the article, will delete its comments together
    has_many :comments, dependent: :destroy
    belongs_to :user
    #validates these requirement, presence = require, must fill in
    validates :title, presence: true
    validates :body, presence: true, length: { minimum: 10 }
end

