# frozen_string_literal:true

json.users do |json|
  json.array! @users do |user|
    json.id user.id
    json.user_name user.user_name
    json.email user.email
    json.role user.role
  end
end
