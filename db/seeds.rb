# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Unit.destroy_all
require 'csv'
YEAR = '2019'
MONTHS = {
    "Ene": '01',
    "Feb": '02'
}
CSV.foreach("#{Rails.root}/db/UF2019.csv", headers: true, col_sep:";") do |row|
    hash = row.to_h
    # hash es algo parecido a esto:
    # {"Día"=>"1", "Ene"=>"27565.79", "Feb"=>"27545.34"}
    day = hash["﻿Dia"]
    months = hash.keys - ["﻿Dia"]
    
    
    months.each do |m|
        month = MONTHS[m.to_sym]
        date = "#{YEAR}-#{month}-#{day}"
        next if  month.nil? 
        value = hash[m].gsub('.', '').gsub(',', '.').to_f 
        Unit.create!(date: date, value: value)
    end
    
end 
