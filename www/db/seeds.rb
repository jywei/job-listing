# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


require 'csv'

Job.create([{ title: "wrestler", category_id: 2, industry_id: 1, contract_type_id: 1, is_published: true, start_day: "2016-08-01", location_id: 1, salary_range_id: 5 },
            { title: "pornstar", category_id: 1, industry_id: 2, contract_type_id: 2, is_published: true, start_day: "2016-05-01", location_id: 3, salary_range_id: 4 },
            { title: "Actor", category_id: 1, industry_id: 2, contract_type_id: 3, is_published: true, start_day: "2016-01-01", location_id: 2, salary_range_id: 3 }])

Category.create([{ name: 'Accounting / Finance' }, { name: 'Sales' }, { name: 'Marketing' }])

Industry.create([{ name: 'Telecommunications Services' }, { name: 'Construction' }, { name: 'Distribution / Logistics' }])

ContractType.create([ { name: 'Full Time'}, { name: 'Part Time'}, { name: 'Internship'}])

SalaryRange.create([ { range: '0 - 99,999 Ks.'}, { range: '100,000 - 249,999 Ks.'}, { range: '250,000 - 499,999 Ks.'}, { range: '500,000 - 749,999 Ks.'}, { range: '750,00 Ks. +'}])

Category.find_each { |category| Category.reset_counters(category.id, :jobs) }

Industry.find_each { |industry| Industry.reset_counters(industry.id, :jobs) }

ContractType.find_each { |contract_type| ContractType.reset_counters(contract_type.id, :jobs) }

SalaryRange.find_each { |salary_range| SalaryRange.reset_counters(salary_range.id, :jobs) }

puts "Importing cities..."
count = 1
CSV.foreach(Rails.root.join("myanmar_city.csv"), headers: false) do |row|
  Location.create! do |location|
    location.id = count
    location.name = row[2]
  end
  count += 1
end

Location.find_each { |location| Location.reset_counters(location.id, :jobs) }
