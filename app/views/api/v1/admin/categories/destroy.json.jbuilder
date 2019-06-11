json.message t ".deleted_successfully"
json.category do
  json.partial! "category", locals: {category: @category}
end
