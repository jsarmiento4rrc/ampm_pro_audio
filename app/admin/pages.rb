ActiveAdmin.register Page do
  permit_params :title, :content, :permalink

  form do |f|
    f.inputs do
      f.input :title
      f.input :permalink, hint: "Use lowercase without spaces (e.g., 'about' or 'contact')"
      f.input :content, as: :text
    end
    f.actions
  end
end