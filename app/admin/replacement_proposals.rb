ActiveAdmin.register ReplacementProposal do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :user_id, :shop_id, :name, :price, :original, :brand, :origin, :life_time, :target, :delivery_time, :conditions, :replacement_request_id, :state
  #
  # or
  #
  # permit_params do
  #   permitted = [:user_id, :shop_id, :name, :price, :original, :brand, :origin, :life_time, :target, :delivery_time, :conditions, :replacement_request_id, :state]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
