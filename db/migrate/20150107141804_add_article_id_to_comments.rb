class AddArticleIdToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :article, index: true if table_exists? :comments
    add_foreign_key :comments, :articles if table_exists? :comments
  end
end
