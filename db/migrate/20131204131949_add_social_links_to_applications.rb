class AddSocialLinksToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :fb_link, :string
    add_column :applications, :twt_link, :string
    add_column :applications, :lin_link, :string
  end
end
