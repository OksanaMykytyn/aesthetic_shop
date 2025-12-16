# db/seeds.rb
require "open-uri"

IMAGE_URL = "https://i.pinimg.com/736x/9f/10/7a/9f107a5735298aed8a968b6fb0c7481d.jpg"

puts "Cleaning DB..."
# Be careful in production!
OrderItem.delete_all
Order.delete_all
CartItem.delete_all
Cart.delete_all
ProductCollection.delete_all
Product.delete_all
Collection.delete_all
Category.delete_all
Review.delete_all
Address.delete_all
User.delete_all

puts "Creating users..."
# Create manager
manager = User.create!(
  email: "manager@example.com",
  password: "password123",
  password_confirmation: "password123",
  first_name: "Manager",
  last_name: "Admin",
  role: "manager",
  is_verified: true
)

# Create some customers
users = []
5.times do |i|
  u = User.create!(
    email: "user#{i+1}@example.com",
    password: "password123",
    password_confirmation: "password123",
    first_name: "User#{i+1}",
    last_name: "Customer",
    role: "client",
    is_verified: true
  )
  users << u

  # Attach avatar
  begin
    u.avatar.attach(io: URI.open(IMAGE_URL), filename: "avatar#{i+1}.jpg")
  rescue => e
    puts "Avatar attach failed: #{e.message}"
  end

  # create default address
  u.addresses.create!(
    label: "Home",
    recipient_name: "#{u.first_name} #{u.last_name}",
    phone: "+38099111222#{i}",
    country: "Ukraine",
    city: "Kyiv",
    postal_code: "0100#{i}",
    street: "Street #{i+1}, #{i+10}",
    delivery_type: ["novaposhta", "ukrposhta", "courier", "poshtomat"].sample,
    branch_number: (1 + i).to_s,
    is_default: true
  )
end

puts "Creating categories..."
categories = []
%w[Зошити Ручки Олівці Блокноти Папір].each_with_index do |name, idx|
  c = Category.create!(name: name, slug: name.parameterize, description: "#{name} description")
  categories << c
  # attach photo
  begin
    c.photo.attach(io: URI.open(IMAGE_URL), filename: "category#{idx+1}.jpg")
  rescue => e
    puts "Category photo attach failed: #{e.message}"
  end
end

puts "Creating collections..."
collections = []
["Kawaii", "Minimal", "Vintage"].each_with_index do |name, idx|
  col = Collection.create!(name: name, slug: name.parameterize, description: "#{name} collection")
  collections << col
  begin
    col.photo.attach(io: URI.open(IMAGE_URL), filename: "collection#{idx+1}.jpg")
  rescue => e
    puts "Collection photo attach failed: #{e.message}"
  end
end

puts "Creating 100 products..."
products = []
100.times do |i|
  title = "Product #{i+1}"
  p = Product.create!(
    title: title,
    slug: title.parameterize,
    sku: "SKU#{1000 + i}",
    description: "Description for #{title}",
    price_cents: ((i + 1) * 100), # e.g. 100, 200, ...
    currency: "UAH",
    stock: 10 + (i % 20),
    category: categories.sample,
    rating_avg: (3.0 + (i % 3)),
    active: true
  )

  # attach image (same image for all)
  begin
    p.images.attach(io: URI.open(IMAGE_URL), filename: "product#{i+1}.jpg")
  rescue => e
    puts "Product image attach failed for #{p.title}: #{e.message}"
  end

  # assign some collections
  if i % 5 == 0
    ProductCollection.create!(product: p, collection: collections.sample)
  end

  products << p
end

puts "Creating carts and cart_items..."
users.each_with_index do |u, idx|
  cart = Cart.create!(user: u, status: "active")
  # add up to 3 items
  1.upto( [3, (idx + 1)].min ) do |n|
    CartItem.create!(cart: cart, product: products.sample, quantity: 1 + (n % 2))
  end
end

puts "Creating orders..."
# Create a few orders for first users
2.times do |i|
  user = users[i]
  order = Order.create!(
    user: user,
    number: "AEST-#{Time.now.to_i}-#{i}",
    status: "new_order",
    total_cents: 0,
    shipping_address: user.addresses.first.as_json,
    billing_address: user.addresses.first.as_json,
    payment_method: "stripe",
    shipping_method: "courier",
    notes: "Test order #{i}",
    promo_code: (i == 1 ? "WELCOME10" : nil),
    promo_discount_cents: (i == 1 ? 100 : 0)
  )

  # add 2 items
  product1 = products.sample
  product2 = products.sample
  oi1 = OrderItem.create!(
    order: order,
    product: product1,
    product_title: product1.title,
    quantity: 1,
    unit_price_cents: product1.price_cents,
    total_price_cents: product1.price_cents * 1
  )
  oi2 = OrderItem.create!(
    order: order,
    product: product2,
    product_title: product2.title,
    quantity: 2,
    unit_price_cents: product2.price_cents,
    total_price_cents: product2.price_cents * 2
  )
  # update total
  order.update!(total_cents: oi1.total_price_cents + oi2.total_price_cents - (order.promo_discount_cents || 0))
end

puts "Creating reviews..."
# random reviews
10.times do
  Review.create!(
    user: users.sample,
    product: products.sample,
    rating: [3,4,5].sample,
    comment: "Nice product",
    approved: true
  )
end

puts "Seeding finished."
