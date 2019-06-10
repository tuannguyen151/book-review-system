json.book do
  json.partial! "book", locals: {book: @book}
end
