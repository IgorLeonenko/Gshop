ActiveAdmin.register Category do
  config.sort_order = 'number_asc'

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  menu priority: 2

  permit_params :title, :description, :short_description, :number, :image

  index do
    id_column
    column :title
    column 'image' do |category|
      image_tag category.image_url(:extra_small) if category.image?
    end
    column :short_description
    column :description
    column :number
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :title
      row :short_description
      row :description
      row :image do
        image_tag category.image_url(:small)
      end
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Category" do
      f.input :title
      f.input :short_description
      f.input :description
      f.input :number
      f.input :image, as: :file,
              hint: f.object.image.present? ? image_tag(f.object.image.url(:small)) : content_tag(:span, "no image uploaded")
    end
    f.actions
  end

end