module AdminHelper
  def admin_permissions(admin)
    admin_permissions = []
    admin.permissions.to_i.to_s(2).reverse.each_char.with_index do |bit, i|
      admin_permissions << (2**i) if bit.to_i == 1
    end
    admin_permissions
  end
end
