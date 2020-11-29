class Tweet < ApplicationRecord
  validates :text, presence: true #バリデーションを設けることでtextが空欄の時データベースに保存できなくなります。
end
