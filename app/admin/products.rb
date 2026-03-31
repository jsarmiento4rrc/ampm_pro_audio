ActiveAdmin.register Product do
  permit_params :product_name, :description, :price, :stock_quantity, :category_id, :image

  # Customize the filters to show readable names
  remove_filter :image_attachment, :image_blob, :order_items
  filter :category, collection: -> { Category.all.map { |c| [c.category_name, c.id] } }
  filter :product_name
  filter :description
  filter :price
  filter :stock_quantity
  filter :created_at
  filter :updated_at

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :category, collection: Category.all.map { |c| [c.category_name, c.id] }
      f.input :product_name
      f.input :description
      f.input :price
      f.input :stock_quantity
      f.input :image, as: :file
    end
    f.actions
  end

  show do
    attributes_table do
      row :category do |product|
        product.category.category_name
      end
      row :product_name
      row :description
      row :price
      row :stock_quantity
      row :image do |product|
        if product.image.attached?
          image_tag url_for(product.image), style: "max-width: 200px;"
        end
      end
    end
  end
end