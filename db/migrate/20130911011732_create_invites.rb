class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.integer  :inviter_id
      t.string   :invitee_name
      t.string   :invitee_email
      t.text     :message
      t.string   :token
      t.timestamps
    end
  end
end
