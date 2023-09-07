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
  {shop_id: shop.id, title: 'dummy product 1', created_by_id: user.id, updated_by_id: user.id},
  {shop_id: shop.id, title: 'dummy product 2', created_by_id: user.id, updated_by_id: user.id},
  {shop_id: shop.id, title: 'dummy product 3', created_by_id: user.id, updated_by_id: user.id},
  {shop_id: shop.id, title: 'dummy product 4', created_by_id: user.id, updated_by_id: user.id}
]);