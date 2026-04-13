class Page < ApplicationRecord
  # Whitelist attributes for ActiveAdmin/Ransack search
  def self.ransackable_attributes(auth_object = nil)
    ["content", "created_at", "id", "permalink", "title", "updated_at"]
  end
end