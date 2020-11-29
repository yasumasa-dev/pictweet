class CreateTweets < ActiveRecord::Migration[6.0]
  def change
    create_table :tweets do |t|
      t.string :name #t.に続くのが「型」で、:に続くのが「カラム名」を指定
      t.string :text
      t.text :image
      t.timestamps
    end
  end
end

#指定したらrails db:migrateを実行してテーブル内のカラムを作成する