class RemoveUserRefFromPhotos < ActiveRecord::Migration
  def change
    remove_reference :photos, :user, index: true
  end
end
