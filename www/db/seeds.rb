# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
Job.create([{ title: "wrestler", category_id: 2, industry_id: 1, is_published: true }, { title: "pornstar", category_id: 1, industry_id: 2, is_published: true }])

Category.create([{ name: 'Accounting / Finance' }, { name: 'Sales' }, { name: 'Marketing' }])

Industry.create([{ name: 'Telecommunications Services' }, { name: 'Construction' }, { name: 'Distribution / Logistics' }])
