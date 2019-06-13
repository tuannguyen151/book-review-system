json.id review.id
json.rate review.rate
json.content review.content
json.user do
  json.id review.user_id
  json.profile do
    json.name review.user_profile_name
  end
end
json.created_at review.created_at
json.updated_at review.updated_at
