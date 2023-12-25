class Comment < ApplicationRecord
  # to allow use Action Text in body
  has_rich_text :body
  # status
  include Visible

  belongs_to :user
  belongs_to :article
end
