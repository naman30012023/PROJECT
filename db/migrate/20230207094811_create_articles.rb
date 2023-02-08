class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.belongs_to :user
      t.string :article_title
      t.text :article_content
      t.datetime :createdOn
      t.string :article_imageURL
      t.integer :nLikes
      t.integer :nComments
      t.timestamps
    end
  end
end
