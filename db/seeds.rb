# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create(
  email: 'kmym.ry826@gmail.com',
  password: 'aaaaaa',
  password_confirmation: 'aaaaaa'
)



CartItem.create(

  item_id: 1,
  customer_id: 1,
  amount: 2
  )