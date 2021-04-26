require "sinatra"

set :default_content_type, "application/json"

PRODUCTS = [
  { id: 1, name: "Apple Computer" },
  { id: 2, name: "Latest Video Game" },
  { id: 3, name: "Baby Toys" },
  { id: 4, name: "Dyson Vacuum Cleaner" },
  { id: 5, name: "Hot Hair Dryer" }
].freeze

post "/search" do
  return [422, { error: "kw param required" }.to_json] if params[:kw].nil?

  product = PRODUCTS.detect { |product| /#{params[:kw]}/i.match?(product[:name]) }

  if product
    product.to_json
  else
    {}.to_json
  end
end

get "/product/:product_id/details" do
  product = PRODUCTS.detect { |product| product[:id] == params[:product_id].to_i }

  if product
    product.to_json
  else
    404
  end
end

post "/cart" do
  product = PRODUCTS.detect { |product| product[:id] == params[:productId].to_i }

  if product
    [201, [product].to_json]
  else
    [422, { error: "Product not found" }.to_json]
  end
end

error Sinatra::NotFound do
  404
end
