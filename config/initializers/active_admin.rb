ActiveAdmin.setup do |config|
  # == Site Title
  config.site_title = "Ampm Pro Audio"

  # == User Authentication
  config.authentication_method = :authenticate_admin_user!
  config.current_user_method = :current_admin_user
  config.logout_link_path = :destroy_admin_user_session_path

  # == Batch Actions
  config.batch_actions = true

  # == Filters
  config.filter_attributes = [:encrypted_password, :password, :password_confirmation]

  # == Localize Date/Time Format
  config.localize_format = :long
end

# Safely inject Ransack allowlists into ActiveStorage models
Rails.application.config.to_prepare do
  ActiveStorage::Attachment.class_eval do
    def self.ransackable_attributes(auth_object = nil)
      ["blob_id", "created_at", "id", "name", "record_id", "record_type"]
    end
  end

  ActiveStorage::Blob.class_eval do
    def self.ransackable_attributes(auth_object = nil)
      ["byte_size", "checksum", "content_type", "created_at", "filename", "id", "key", "metadata"]
    end
    
    def self.ransackable_associations(auth_object = nil)
      ["attachments", "variant_records"]
    end
  end
end