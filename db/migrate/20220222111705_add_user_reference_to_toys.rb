class AddUserReferenceToToys < ActiveRecord::Migration[6.1]
  def change
    add_reference :toys, :user, null: false, foreign_key: true
  end
end
