class AddAttachmentAvatarToApplications < ActiveRecord::Migration
  def self.up
    change_table :applications do |t|
      t.attachment :avatar
    end
  end

  def self.down
    drop_attached_file :applications, :avatar
  end
end
