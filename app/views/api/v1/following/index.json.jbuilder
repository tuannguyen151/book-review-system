json.users @users do |user|
  json.partial! "api/v1/shared/user", user: user
end
json.page_count @page_count
json.total_pages @users.total_pages
