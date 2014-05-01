# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

a = []
100.times do |i|
  u = User.new(email: Faker::Internet.safe_email,
                  name: Faker::Internet.user_name,
                  password: "123123",
                  bio: Faker::Company.bs,
                  activate: true)
  u.save if u.valid?
  a << u
end

# user need avatars
# patterns need photos

b = (1...10).to_a
1000.times do |i|
  # user connections
  u = a.sample
  u2 = a.sample
  u.leaders << u2 unless u.leaders.include?(u2)

  # messages
  body = "Hi there #{u2.show_name}, its nice to see you around here, #{u.show_name}"
  m = u.sent_messages.create(body: body, receiver_id: u2.id)

  # patterns
  name = Faker::Commerce.product_name
  yarn_name = Faker::Commerce.color + " by " + Faker::Company.name
  yarn_weight = b.sample.to_s
  stitch_col = b.sample.to_s
  stitch_row = b.sample.to_s
  swatch = "4 inches"
  swatch_stitch = "stockenette stitch"
  needles = "US " + (2 * b.sample).to_s
  amount_yarn = "Enough"
  price = "free"
  u.designs.create(name: name, yarn_name: yarn_name, yarn_weight: yarn_weight, stitch_col: stitch_col,
                    stitch_row: stitch_row, swatch: swatch, swatch_stitch: swatch_stitch, needles: needles,
                    amount_yarn: amount_yarn, price: price)
end
