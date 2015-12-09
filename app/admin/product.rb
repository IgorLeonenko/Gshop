ActiveAdmin.register Product do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters

  menu priority: 3

  permit_params :title, :short_description, :description, :article, :image, :price, :category_id, :quantity
  
  index do
    id_column
    column :title
    column 'image' do |product|
      if product.image?
        image_tag product.image_url(:extra_small)
      else
        image_tag 'no_image.png', width: '100%'
      end
    end
    column :short_description
    column 'description' do |product|
      product.description.truncate(200)
    end
    column :article
    column :price
    column :quantity
    column 'category' do |product|
      product.category.title
    end
    actions
  end

  show do
    attributes_table do
      row :title
      row :image do
        if product.image?
        image_tag product.image_url(:small)
      else
        image_tag 'no_image.png', width: '30%'
      end
      end
      row :short_description
      row :description
      row :article
      row :price
      row :quantity
      row 'category' do |product|
        product.category.title
      end
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Product" do
      f.input :title
      f.input :article
      f.input :short_description
      f.input :description
      f.input :quantity, as: :number
      f.input :price
      f.input :image, as: :file,
              hint: f.object.image.present? ? image_tag(f.object.image.url(:small)) : image_tag( 'no_image.png', width: '30%' )
      f.input :category_id, as: :select, collection: Category.all.map{|c| [c.title, c.id]}, include_blank: false
    end
    f.actions
  end

end