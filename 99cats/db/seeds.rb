# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create!([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create!(name: 'Emanuel', city: cities.first)


manny = User.new(user_name: "manny")
manny.password="goredsox"
manny.save!
moe = User.new(user_name: "moe")
moe.password="wiseguyeh?"
moe.save!
jack = User.new(user_name: "jack")
jack.password="masterofnone"
jack.save!

babycakes = Cat.create!(
              birth_date: "2015-03-10",
              color: "orange", 
              name: "Mr.Babycakes", 
              sex: "F", 
              user_id: 1,
              description: " Wowza! "
)
scratchy = Cat.create!(
            birth_date: "1999-02-02", 
            color: "black", 
            name: "Scratchy", 
            sex: "F",
            user_id: 2,
            description: "scratching"
)

CatRentalRequest.create!(cat_id: 1,
                        start_date: "2015-02-28",
                        end_date: "2015-03-10",
                        status: "Approved",
                        user_id: 2
                       )
CatRentalRequest.create!(cat_id: 1,
                        start_date: "2015-03-11",
                        end_date: "2015-04-04",
                        status: "Approved",
                        user_id: 2
                       )
CatRentalRequest.create!(cat_id: 1,
                        start_date: "2015-03-02",
                        end_date: "2015-03-05",
                        status: "Denied",
                        user_id: 2
                       )
CatRentalRequest.create!(cat_id: 1,
                        start_date: "2015-03-10",
                        end_date: "2015-03-12",
                        status: "Denied",
                        user_id: 2
                       )
CatRentalRequest.create!(cat_id: 1,
                        start_date: "2015-03-10",
                        end_date: "2015-03-11",
                        status: "Denied",
                        user_id: 2
                       )
def rand_day_very_soon
  rand(10).days.from_now
end

def rand_day_soon
  (rand(10)+10).days.from_now
end
5.times do |n|
  puts "#{n} new cats"
  pickles = Cat.new(name: "Pickles #{n}", color: "orange", 
                    sex: "M", user_id: (1+rand(3)),
                    description: "#{"very "*n}Sour",
                    birth_date: 5.years.ago.to_date)
  pickles.save!
  3.times do |m|
    puts "#{n}th cat, #{m}th request"
    a = CatRentalRequest.new(cat_id: pickles.id, user_id: m+1,
                             start_date: rand_day_very_soon, 
                             end_date: rand_day_soon)
    a.save!
  end
end

puts "#{Cat.count} total cats"
puts "#{CatRentalRequest.count} total cat requests"

