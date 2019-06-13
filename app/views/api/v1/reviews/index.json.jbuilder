json.reviews @reviews do |review|
  json.partial! "review", review: review
end
json.partial! "api/v1/shared/pagination", collection: @reviews
