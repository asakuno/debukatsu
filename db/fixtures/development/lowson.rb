require 'csv'

user = User.find_by(name: 'Admin', role: 2)

csv = CSV.read('db/fixtures/test.csv', encoding: 'UTF-16')

csv.each do |row|
  food_id = row['Id']
  image = row['Image']
  food_name = row['food_name']
  price= row['Price']
  calorie = row['calorie']
  tag_list = row['tag'].split(',')

  Food.seed(:food_id) do |id|
    id.food_id = food_id
    id.food_name = food_name
    id.image = image
    id.price = price
    id.calorie = calorie
    id.tag_list = tag_list
    id.user_id = user.id
  end
end