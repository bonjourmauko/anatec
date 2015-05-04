json.array!(@books) do |book|
  json.extract! book, :id, :author_id, :title, :user_id, :user_id
  json.url book_url(book, format: :json)
end
