json.title book.title
json.cover book.cover_image_url
json.publish_date book.publish_date
json.number_pages book.number_pages
json.author book.author
json.price book.price
json.description book.description
json.category do
  json.name book.category_name
end
json.updated_at book.updated_at
