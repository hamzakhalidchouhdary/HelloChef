# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create({
  first_name: 'Hamza',
  last_name: 'Khalid',
  username: 'hamza',
  password_digest: '12345',
  email: 'hamza@helloChef.com',
  created_by_id: 1,
  updated_by_id: 1
});
organization = Organization.create({ 
  name: 'KK Group',
  created_by_id: user.id,
  updated_by_id: user.id
});
shop = Shop.create({
  name: 'KK Store',
  organization_id: organization.id,
  created_by_id: user.id,
  updated_by_id: user.id
});
Item.create([
  {
    shop_id: shop.id,
    title: 'dummy product 1',
    price: 5.0,
    description: 'Want a superweapon to ignite your customer’s interest in a product? It’s right under your nose: Take your product’s unique features and turn them into benefits.',
    created_by_id: user.id,
    updated_by_id: user.id
  },
  {
    shop_id: shop.id,
    title: 'dummy product 2',
    price: 51.0,
    description: 'Want a superweapon to ignite your customer’s interest in a product? It’s right under your nose: Take your product’s unique features and turn them into benefits.',
    created_by_id: user.id,
    updated_by_id: user.id
  },
  {
    shop_id: shop.id,
    title: 'dummy product 4',
    price: 15.0,
    description: 'This description below does so much more than introduce a backpack and explain how many items it can hold. It tells (you guessed it) a story.',
    created_by_id: user.id,
    updated_by_id: user.id
  },
  {
    shop_id: shop.id,
    title: 'dummy product 5',
    price: 28.0,
    description: 'Want a superweapon to ignite your customer’s interest in a product? It’s right under your nose: Take your product’s unique features and turn them into benefits.',
    created_by_id: user.id,
    updated_by_id: user.id
  },
  {
    shop_id: shop.id,
    title: 'dummy product 6',
    price: 510.0,
    description: 'Hemp grows wild throughout Nepal and has long been used to create fabrics used in clothe making etc. You can now own a piece of this ancient tradition in the form of a functional, stylish laptop case.',
    created_by_id: user.id,
    updated_by_id: user.id
  },
  {
    shop_id: shop.id,
    title: 'dummy product 7',
    price: 125.0,
    description: 'Designed and measured to fit a 12″ to 14″ laptops and with a convenient front pocket for your charger cable and notebook. We can also make you a custom sized and coloured sleeve to fit your laptop/macbook or tablet. Get in touch for details.',
    created_by_id: user.id,
    updated_by_id: user.id
  },
  {
    shop_id: shop.id,
    title: 'dummy product 8',
    price: 25.0,
    description: 'Beautifully handmade laptop case/sleeve made in the Nepal Himalaya. It can be slipped inside your backpack or carried alone with space for all your work bits and pieces!',
    created_by_id: user.id,
    updated_by_id: user.id
  },
]);