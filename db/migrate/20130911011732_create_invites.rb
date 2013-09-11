class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.string "full_name"
      t.integer "inviter_id"
      t.string "invitee_email"
      t.string "token"
      t.timestamps
    end
  end
end
