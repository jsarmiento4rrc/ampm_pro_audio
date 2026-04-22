ActiveAdmin.register Page do
  permit_params :title, :content, :permalink

  form do |f|
    f.inputs do
      f.input :title
      f.input :permalink, hint: "Used for the URL (e.g., 'about' or 'contact'). Use lowercase, no spaces."
      f.input :content
    end
    f.actions
  end
end