json.message t ".deleted_successfully"
json.review do
  json.partial! "review", locals: {review: @review}
end
