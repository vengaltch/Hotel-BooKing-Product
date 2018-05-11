ActiveAdmin.register RoomType do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :name, :cost, :amenities
  form do |f|
    f.inputs "Room Type" do
      f.input :name
      f.input :cost
      f.input :amenities, as: :select, collection: Amenity.all, include_blank: false, multiple: true
    end
    f.actions
  end

  member_action :create, method: [:post] do
    room_data = params[:room_type]
    room_type = RoomType.create(name: room_data[:name], cost: room_data[:cost])
    room_data[:amenity_ids].each do |amenity_id|
      if amenity_id != ''
        RoomAmenity.where(room_type_id: room_type.id, amenity_id: amenity_id).first_or_create
      end
    end
    redirect_to "/admin/room_types/#{room_type.id}"
  end

  member_action :update, method: [:patch] do
    room_type = RoomType.where(id: params[:id]).first
    # room_type.name = 
    # binding.pry

    room_data = params[:room_type]
    room_type.name = room_data[:name]
    room_type.cost = room_data[:cost]
    room_type.save
    RoomAmenity.where(room_type_id: room_type.id).destroy_all
    room_data[:amenity_ids].each do |amenity_id|
      if amenity_id != ''
        RoomAmenity.where(room_type_id: room_type.id, amenity_id: amenity_id).first_or_create
      end
    end
    redirect_to "/admin/room_types/#{room_type.id}"
  end
end
