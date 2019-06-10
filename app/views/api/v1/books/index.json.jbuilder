json.books @books do |book|
  json.partial! "book", book: book
end
json.partial! "api/v1/shared/pagination", collection: @books
