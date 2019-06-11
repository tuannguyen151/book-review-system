json.message t ".created_successfully"
json.category do
  json.partial! "category", locals: {category: @category}
end
