class Tweet < ApplicationRecord
  validates :text, presence: true #バリデーションを設けることでtextが空欄の時データベースに保存できなくなります。
  belongs_to :user
  has_many :comments

  def self.search(search)
    if search != ""
      Tweet.where('text LIKE(?)', "%#{search}%")
    else
      Tweet.all
    end
  end
end
