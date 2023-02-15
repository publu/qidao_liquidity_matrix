require 'open-uri'
require 'nokogiri'
require 'task_helpers/tokens_helper'
require 'statistics'

namespace :prices do
  desc 'Update prices with latest data'

  task all: :environment do
    @days = [90,
             89,88,87,86,85,84,83,82,81,80,
             79,78,77,76,75,74,73,72,71,70,
             69,68,67,66,65,64,63,62,61,60,
             59,58,57,56,55,54,53,52,51,50,
             49,48,47,46,45,44,43,42,41,40,
             39,38,37,36,35,34,33,32,31,30,
             29,28,27,26,25,24,23,22,21,20,
             19,18,17,16,15,14,13,12,11,10,
             9,8,7,6,5,4,3,2,1]
    @days.each do |d|
      Token.all.each do |token|
        if Price.where(token_id: token.id, price_date: (Time.now - d.day).end_of_day).exists?
          puts "Skipping " + token.symbol + " (" + token.network.name + "). Prices for " + (Time.now - d.days).strftime("%b %d, %Y") + " already in database."
        else
          puts "Adding closing price for " + token.symbol + " (" + token.network.name + ") for " + (Time.now - d.days).beginning_of_day.to_s
          if d == 90
            url = "https://coins.llama.fi/prices/historical/" + ((Time.now - (d.days)).end_of_day.to_i).to_s + "/" + token.network.gecko_id + ":" + token.contract_address
            uri = URI(url)
            response = Net::HTTP.get(uri)
            closing = JSON.parse(response)
            url2 = "https://coins.llama.fi/prices/historical/" + ((Time.now - ((d + 1).days)).end_of_day.to_i).to_s + "/" + token.network.gecko_id + ":" + token.contract_address
            uri2 = URI(url2)
            response2 = Net::HTTP.get(uri2)
            closing2 = JSON.parse(response2)
            Price.create(
              asset: token.asset,
              token_id: token.id,
              closing_price: closing["coins"]["#{token.network.gecko_id}:#{token.contract_address}"]["price"].to_d,
              price_date: (Time.now - d.days).end_of_day,
              natural_log: Math.log((closing2["coins"]["#{token.network.gecko_id}:#{token.contract_address}"]["price"]).to_d/(closing["coins"]["#{token.network.gecko_id}:#{token.contract_address}"]["price"]).to_d),
              volatility: "0.00 ")
              sleep 3
          else
            url = "https://coins.llama.fi/prices/historical/" + ((Time.now - (d.days)).end_of_day.to_i).to_s + "/" + token.network.gecko_id + ":" + token.contract_address
            uri = URI(url)
            response = Net::HTTP.get(uri)
            closing = JSON.parse(response)
            Price.create(
              asset: token.asset,
              token_id: token.id,
              closing_price: closing["coins"]["#{token.network.gecko_id}:#{token.contract_address}"]["price"].to_d,
              price_date: (Time.now - d.days).end_of_day,
              natural_log: Math.log(Price.where(token_id: token.id).order(price_date: :desc).last.closing_price.to_d/(closing["coins"]["#{token.network.gecko_id}:#{token.contract_address}"]["price"]).to_d))
            sleep 1
            token.prices.last.update(
              volatility: (Price.where(token_id: token.id).order(price_date: :desc).pluck(:natural_log).each {|p| p }).standard_deviation)
            sleep 0.5
          end
        end
        token.update(risk_volatility: Price.where(token_id: token.id).order(price_date: :desc).first.volatility)
      end
      puts "Closing price update completed."
    end
  end

  task pastweek: :environment do
    @days = [7,6,5,4,3,2,1]
    @days.each do |d|
      Token.all.each do |token|
        if Price.where(token_id: token.id, price_date: (Time.now - d.day).end_of_day).exists?
          puts "Skipping " + token.symbol + " (" + token.network.name + "). Prices for " + (Time.now - d.days).strftime("%b %d, %Y") + " already in database."
        else
          puts "Adding closing price for " + token.symbol + " (" + token.network.name + ") for " + (Time.now - d.days).beginning_of_day.to_s
            url = "https://coins.llama.fi/prices/historical/" + ((Time.now - (d.days)).end_of_day.to_i).to_s + "/" + token.network.gecko_id + ":" + token.contract_address
            uri = URI(url)
            response = Net::HTTP.get(uri)
            closing = JSON.parse(response)
            Price.create(
              asset: token.asset,
              token_id: token.id,
              closing_price: closing["coins"]["#{token.network.gecko_id}:#{token.contract_address}"]["price"].to_d,
              price_date: (Time.now - d.days).end_of_day,
              natural_log: Math.log(Price.where(token_id: token.id).order(price_date: :desc).last.closing_price.to_d/(closing["coins"]["#{token.network.gecko_id}:#{token.contract_address}"]["price"]).to_d))
            sleep 1
            token.prices.last.update(
              volatility: (Price.where(token_id: token.id).order(price_date: :desc).pluck(:natural_log).each {|p| p }).standard_deviation)
            sleep 0.5
        end
        token.update(risk_volatility: Price.where(token_id: token.id).order(price_date: :desc).first.volatility)
      end
      puts "Closing price update completed."
    end
  end

end
