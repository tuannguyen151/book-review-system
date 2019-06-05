json.id user.id
json.email user.email
json.created_at user.created_at
json.profile do
  json.name user.user_profile_name
  json.image user.user_profile_image
  json.gender user.user_profile_gender
  json.birthday user.user_profile_birthday
  json.address user.user_profile_address
  json.phone user.user_profile_phone
end
