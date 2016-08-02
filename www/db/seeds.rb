# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
Job.create([{ title: "wrestler", category_id: 2, industry_id: 1, contract_type_id: 1, is_published: true, start_day: "2016-08-01" },
            { title: "pornstar", category_id: 1, industry_id: 2, contract_type_id: 2, is_published: true, start_day: "2016-05-01" },
            { title: "Actor", category_id: 1, industry_id: 2, contract_type_id: 3, is_published: true, start_day: "2016-01-01" }])

Category.create([{ name: 'Accounting / Finance' }, { name: 'Sales' }, { name: 'Marketing' }])

Industry.create([{ name: 'Telecommunications Services' }, { name: 'Construction' }, { name: 'Distribution / Logistics' }])

ContractType.create([ { name: 'Full Time'}, { name: 'Part Time'}, { name: 'Internship'}])

Category.find_each { |category| Category.reset_counters(category.id, :jobs) }

Industry.find_each { |industry| Industry.reset_counters(industry.id, :jobs) }

ContractType.find_each { |contract_type| ContractType.reset_counters(contract_type.id, :jobs) }
