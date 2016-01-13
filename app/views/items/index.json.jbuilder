json.array!(@items) do |item|
  json.extract! item, :id, :title, :description, :price, :image_url, :category, :brand
  json.url item_url(item, format: :json)
end
