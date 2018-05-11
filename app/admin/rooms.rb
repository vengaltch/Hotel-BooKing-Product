ActiveAdmin.register Room do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# attr_accessor :bulk_upload
permit_params :name, :room_type_id, :bulk_upload

  form do |f|
    f.inputs "Room Type" do
      f.input :name
      f.input :room_type_id, as: :select, collection: RoomType.all, include_blank: false
      f.input :bulk_upload, placeholder: 'A 01-05'
    end
    f.actions
  end

  member_action :create, method: [:post] do
    room_data = params[:room]
    if room_data[:bulk_upload] == ''
      room_type = RoomType.create(name: room_data[:name], cost: room_data[:cost])
      room_data[:amenity_ids].each do |amenity_id|
        if amenity_id != ''
          RoomAmenity.where(room_type_id: room_type.id, amenity_id: amenity_id).first_or_create
        end
      end
    else
      spliter = room_data[:bulk_upload].split(' ')
      room_name = spliter[0]
      room_first = spliter[1].split('-')[0].to_i
      room_end = spliter[1].split('-')[1].to_i
      ((room_first..room_end).to_a).each do |x|
        room_type = Room.create(name: "#{room_name} #{x}", room_type_id: room_data[:room_type_id])
      end
    end
    redirect_to "/admin/rooms"
  end

end
