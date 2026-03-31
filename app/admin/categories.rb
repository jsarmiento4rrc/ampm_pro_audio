ActiveAdmin.register Category do
  permit_params :category_name

  # Clean up the filters panel
  remove_filter :products
  filter :category_name
  filter :created_at
  filter :updated_at
end