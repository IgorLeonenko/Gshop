ActiveAdmin.register Order do
  menu priority: 4
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
  permit_params :status


  index do
    id_column
    column :name
    column :last_name
    column :email
    column :phone
    column :address
    column :status
    actions
  end

  show do |order|
    attributes_table do
      row :email
      row :name
      row :last_name
      row :address
      row :phone
      row :status
    end
    panel("Items") do
      table_for(order.line_items) do
        column "Title" do |i| 
          i.product.title
        end
        column "Image" do |i|
          image_tag i.product.image_url(:extra_small)
        end
        column :quantity
        column "Price" do |i| 
          number_to_currency i.price
        end
      end
    end
    panel("Total order price") do
      number_to_currency order.line_items.to_a.sum{ |item| item.total_price }
    end
  end

  form do |f|
    f.inputs 'Order' do
      f.semantic_errors *f.object.errors.keys
      f.input :status, as: :select, collection: Order::STATUS, include_blank: false
    end
    panel("Items") do
      table_for(order.line_items) do
        column "Title" do |i| 
          i.product.title
        end
        column "Image" do |i|
          image_tag i.product.image_url(:extra_small)
        end
        column :quantity
        column "Price" do |i| 
          number_to_currency i.price
        end
      end
    end
    panel("Total order price") do
      number_to_currency order.line_items.to_a.sum{ |item| item.total_price }
    end
    f.actions
  end
end
