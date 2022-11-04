require 'open-uri'
require 'nokogiri'
require 'task_helpers/tokens_helper'

namespace :chains do
  desc 'Update chains with latest data'

  task liquidity: :environment do
    Network.all.each do |network|
      puts "Updating liquidity for " + network.name
      network.update(liquidity: (network.tokens.sum(:liquidity)))
      puts "Completed."
    end
    puts "Liquidity update completed."
  end

  task volume: :environment do
    Network.all.each do |network|
      puts "Updating volume for " + network.name
      network.update(volume: (network.tokens.sum(:volume)))
      puts "Completed."
    end
    puts "Volume update completed."
  end

  task debtamount: :environment do
    Network.all.each do |network|
      puts "Updating debt for " + network.name
      network.update(debtamount: (network.tokens.sum(:mai_debt)))
      puts "Completed."
    end
    puts "Debt amount update completed."
  end

  task debtpercent: :environment do
    Network.all.each do |network|
      puts "Updating debt percentage for " + network.name
      network.update(debtpercent: ((((network.tokens.sum(:mai_debt).to_f) / (Token.all.sum(:mai_debt).to_f)) * 100).round(6)))
      puts "Completed."
    end
    puts "Debt percentage update completed."
  end
end
