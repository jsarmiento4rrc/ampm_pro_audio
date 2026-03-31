ActiveAdmin.register Product do
  permit_params :product_name, :description, :price, :stock_quantity, :category_id, :image

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :category
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
      row :category
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