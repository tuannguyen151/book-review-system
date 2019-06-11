json.message t ".updated_successfully"
json.category do
  json.partial! "category", locals: {category: @category}
end
