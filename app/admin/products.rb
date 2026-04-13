ActiveAdmin.register Product do
  permit_params :product_name, :description, :price, :stock_quantity, :category_id, :image

  # Customize the index page table
  index do
    selectable_column
    id_column
    column "Image" do |product|
      if product.image.attached?
        image_tag product.image, style: "width: 50px; height: 50px; object-fit: contain;"
      else
        "No Image"
      end
    end
    column :product_name
    column :category
    column :price do |product|
      number_to_currency(product.price)
    end
    column :stock_quantity
    actions
  end

  # Customize the single product view
  show do
    attributes_table do
      row :product_name
      row :category
      row :price do |product|
        number_to_currency(product.price)
      end
      row :stock_quantity
      row :description
      row :image do |product|
        if product.image.attached?
          image_tag product.image, style: "max-width: 300px; max-height: 300px; object-fit: contain;"
        else
          span "No image attached"
        end
      end
    end
  end

  # Customize the new/edit form
  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :category
      f.input :product_name
      f.input :description
      f.input :price
      f.input :stock_quantity
      
      # The file upload field
      f.input :image, as: :file, hint: f.object.image.attached? ? image_tag(f.object.image, style: "max-width: 100px; margin-top: 10px;") : content_tag(:span, "Upload a JPG or PNG")
    end
    f.actions
  end
end