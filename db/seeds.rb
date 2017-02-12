# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ManagedTwitterAccount.create(username: '961wefm')
ManagedTwitterAccount.create(username: 'star947tt')
ManagedTwitterAccount.create(username: 'briantigerchow')

Station.create(name: 'Kaiso')
Station.create(name: 'Music for Life', tag: '1077fm')
Station.create(name: 'STAR', tag: '947fm')
Station.create(name: 'WEFM', tag: '961fm')

u = User.new(
  full_name: 'btc',
  email: 'brian.holderchow@gmail.com',
  password: 'foobar')
u.skip_confirmation!
u.save!

NewsCategory.create(name: 'Sports')
NewsCategory.create(name: 'News')
NewsCategory.create(name: 'Arts')
NewsCategory.create(name: 'Business')
