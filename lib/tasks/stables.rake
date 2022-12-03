require 'open-uri'
require 'nokogiri'
require 'task_helpers/tokens_helper'
require 'statistics'

namespace :stables do
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
      Stable.all.each do |stable|
        if Stableprice.where(stable_id: stable.id, price_date: (Time.now - d.day).end_of_day).exists?
          puts "Skipping " + stable.symbol + ". Prices for " + (Time.now - d.days).strftime("%b %d, %Y") + " already in database."
        else
          puts "Adding closing price for " + stable.symbol + " for " + (Time.now - d.days).beginning_of_day.to_s + "(" + (Time.now - d.days).end_of_day.to_i.to_s + ")"
          if d == 90
            url = "https://coins.llama.fi/prices/historical/" + ((Time.now - (d.days)).end_of_day.to_i).to_s + "/" + stable.gecko_id + ":" + stable.contract_address
            uri = URI(url)
            response = Net::HTTP.get(uri)
            closing = JSON.parse(response)
            url2 = "https://coins.llama.fi/prices/historical/" + ((Time.now - ((d + 1).days)).end_of_day.to_i).to_s + "/" + stable.gecko_id + ":" + stable.contract_address
            uri2 = URI(url2)
            response2 = Net::HTTP.get(uri2)
            closing2 = JSON.parse(response2)
            Stableprice.create(
              asset: stable.asset,
              stable_id: stable.id,
              closing_price: closing["coins"]["#{stable.gecko_id}:#{stable.contract_address}"]["price"].to_d,
              price_date: (Time.now - d.days).end_of_day,
              natural_log: Math.log((closing2["coins"]["#{stable.gecko_id}:#{stable.contract_address}"]["price"]).to_d/(closing["coins"]["#{stable.gecko_id}:#{stable.contract_address}"]["price"]).to_d),
              volatility: "0.00 ")
              sleep 3
          else
            url = "https://coins.llama.fi/prices/historical/" + ((Time.now - (d.days)).end_of_day.to_i).to_s + "/" + stable.gecko_id + ":" + stable.contract_address
            uri = URI(url)
            response = Net::HTTP.get(uri)
            closing = JSON.parse(response)
            Stableprice.create(
              asset: stable.asset,
              stable_id: stable.id,
              closing_price: closing["coins"]["#{stable.gecko_id}:#{stable.contract_address}"]["price"].to_d,
              price_date: (Time.now - d.days).end_of_day,
              natural_log: Math.log(Stableprice.where(stable_id: stable.id).order(price_date: :desc).last.closing_price.to_d/(closing["coins"]["#{stable.gecko_id}:#{stable.contract_address}"]["price"]).to_d))
            sleep 1
            stable.stableprices.last.update(
              volatility: (Stableprice.where(stable_id: stable.id).order(price_date: :desc).pluck(:natural_log).each {|p| p }).standard_deviation)
            sleep 0.5
          end
        end
        stable.update(risk_volatility: Stableprice.where(stable_id: stable.id).order(price_date: :desc).first.volatility)
      end
      puts "Closing price update completed."
    end
  end

  task mai: :environment do
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
      Stable.where(symbol: "MAI").each do |stable|
        if Stableprice.where(stable_id: stable.id, price_date: (Time.now - d.day).end_of_day).exists?
          puts "Skipping " + stable.symbol + ". Prices for " + (Time.now - d.days).strftime("%b %d, %Y") + " already in database."
        else
          puts "Adding closing price for " + stable.symbol + " for " + (Time.now - d.days).beginning_of_day.to_s
          if d == 90
            url = "https://coins.llama.fi/prices/historical/" + ((Time.now - (d.days)).end_of_day.to_i).to_s + "/" + stable.gecko_id + ":" + stable.contract_address
            uri = URI(url)
            response = Net::HTTP.get(uri)
            closing = JSON.parse(response)
            url2 = "https://coins.llama.fi/prices/historical/" + ((Time.now - ((d + 1).days)).end_of_day.to_i).to_s + "/" + stable.gecko_id + ":" + stable.contract_address
            uri2 = URI(url2)
            response2 = Net::HTTP.get(uri2)
            closing2 = JSON.parse(response2)
            Stableprice.create(
              asset: stable.asset,
              stable_id: stable.id,
              closing_price: closing["coins"]["#{stable.gecko_id}:#{stable.contract_address}"]["price"].to_d,
              price_date: (Time.now - d.days).end_of_day,
              natural_log: Math.log((closing2["coins"]["#{stable.gecko_id}:#{stable.contract_address}"]["price"]).to_d/(closing["coins"]["#{stable.gecko_id}:#{stable.contract_address}"]["price"]).to_d),
              volatility: "0.00 ")
              sleep 3
          else
            url = "https://coins.llama.fi/prices/historical/" + ((Time.now - (d.days)).end_of_day.to_i).to_s + "/" + stable.gecko_id + ":" + stable.contract_address
            uri = URI(url)
            response = Net::HTTP.get(uri)
            closing = JSON.parse(response)
            Stableprice.create(
              asset: stable.asset,
              stable_id: stable.id,
              closing_price: closing["coins"]["#{stable.gecko_id}:#{stable.contract_address}"]["price"].to_d,
              price_date: (Time.now - d.days).end_of_day,
              natural_log: Math.log(Stableprice.where(stable_id: stable.id).order(price_date: :desc).last.closing_price.to_d/(closing["coins"]["#{stable.gecko_id}:#{stable.contract_address}"]["price"]).to_d))
            sleep 1
            stable.stableprices.last.update(
              volatility: (Stableprice.where(stable_id: stable.id).order(price_date: :desc).pluck(:natural_log).each {|p| p }).standard_deviation)
            sleep 0.5
          end
        end
        stable.update(risk_volatility: Stableprice.where(stable_id: stable.id).order(price_date: :desc).first.volatility)
      end
    end
  end

  task alusd: :environment do
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
      Stable.where(symbol: "alUSD").each do |stable|
        if Stableprice.where(stable_id: stable.id, price_date: (Time.now - d.day).end_of_day).exists?
          puts "Skipping " + stable.symbol + ". Prices for " + (Time.now - d.days).strftime("%b %d, %Y") + " already in database."
        else
          puts "Adding closing price for " + stable.symbol + " for " + (Time.now - d.days).beginning_of_day.to_s
          if d == 90
            url = "https://coins.llama.fi/prices/historical/" + ((Time.now - (d.days)).end_of_day.to_i).to_s + "/" + stable.gecko_id + ":" + stable.contract_address
            uri = URI(url)
            response = Net::HTTP.get(uri)
            closing = JSON.parse(response)
            url2 = "https://coins.llama.fi/prices/historical/" + ((Time.now - ((d + 1).days)).end_of_day.to_i).to_s + "/" + stable.gecko_id + ":" + stable.contract_address
            uri2 = URI(url2)
            response2 = Net::HTTP.get(uri2)
            closing2 = JSON.parse(response2)
            Stableprice.create(
              asset: stable.asset,
              stable_id: stable.id,
              closing_price: closing["coins"]["#{stable.gecko_id}:#{stable.contract_address}"]["price"].to_d,
              price_date: (Time.now - d.days).end_of_day,
              natural_log: Math.log((closing2["coins"]["#{stable.gecko_id}:#{stable.contract_address}"]["price"]).to_d/(closing["coins"]["#{stable.gecko_id}:#{stable.contract_address}"]["price"]).to_d),
              volatility: "0.00 ")
              sleep 3
          else
            url = "https://coins.llama.fi/prices/historical/" + ((Time.now - (d.days)).end_of_day.to_i).to_s + "/" + stable.gecko_id + ":" + stable.contract_address
            uri = URI(url)
            response = Net::HTTP.get(uri)
            closing = JSON.parse(response)
            Stableprice.create(
              asset: stable.asset,
              stable_id: stable.id,
              closing_price: closing["coins"]["#{stable.gecko_id}:#{stable.contract_address}"]["price"].to_d,
              price_date: (Time.now - d.days).end_of_day,
              natural_log: Math.log(Stableprice.where(stable_id: stable.id).order(price_date: :desc).last.closing_price.to_d/(closing["coins"]["#{stable.gecko_id}:#{stable.contract_address}"]["price"]).to_d))
            sleep 1
            stable.stableprices.last.update(
              volatility: (Stableprice.where(stable_id: stable.id).order(price_date: :desc).pluck(:natural_log).each {|p| p }).standard_deviation)
            sleep 0.5
          end
        end
        stable.update(risk_volatility: Stableprice.where(stable_id: stable.id).order(price_date: :desc).first.volatility)
      end
    end
  end

  task lusd: :environment do
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
      Stable.where(symbol: "LUSD").each do |stable|
        if Stableprice.where(stable_id: stable.id, price_date: (Time.now - d.day).end_of_day).exists?
          puts "Skipping " + stable.symbol + ". Prices for " + (Time.now - d.days).strftime("%b %d, %Y") + " already in database."
        else
          puts "Adding closing price for " + stable.symbol + " for " + (Time.now - d.days).beginning_of_day.to_s
          if d == 90
            url = "https://coins.llama.fi/prices/historical/" + ((Time.now - (d.days)).end_of_day.to_i).to_s + "/" + stable.gecko_id + ":" + stable.contract_address
            uri = URI(url)
            response = Net::HTTP.get(uri)
            closing = JSON.parse(response)
            url2 = "https://coins.llama.fi/prices/historical/" + ((Time.now - ((d + 1).days)).end_of_day.to_i).to_s + "/" + stable.gecko_id + ":" + stable.contract_address
            uri2 = URI(url2)
            response2 = Net::HTTP.get(uri2)
            closing2 = JSON.parse(response2)
            Stableprice.create(
              asset: stable.asset,
              stable_id: stable.id,
              closing_price: closing["coins"]["#{stable.gecko_id}:#{stable.contract_address}"]["price"].to_d,
              price_date: (Time.now - d.days).end_of_day,
              natural_log: Math.log((closing2["coins"]["#{stable.gecko_id}:#{stable.contract_address}"]["price"]).to_d/(closing["coins"]["#{stable.gecko_id}:#{stable.contract_address}"]["price"]).to_d),
              volatility: "0.00 ")
              sleep 3
          else
            url = "https://coins.llama.fi/prices/historical/" + ((Time.now - (d.days)).end_of_day.to_i).to_s + "/" + stable.gecko_id + ":" + stable.contract_address
            uri = URI(url)
            response = Net::HTTP.get(uri)
            closing = JSON.parse(response)
            Stableprice.create(
              asset: stable.asset,
              stable_id: stable.id,
              closing_price: closing["coins"]["#{stable.gecko_id}:#{stable.contract_address}"]["price"].to_d,
              price_date: (Time.now - d.days).end_of_day,
              natural_log: Math.log(Stableprice.where(stable_id: stable.id).order(price_date: :desc).last.closing_price.to_d/(closing["coins"]["#{stable.gecko_id}:#{stable.contract_address}"]["price"]).to_d))
            sleep 1
            stable.stableprices.last.update(
              volatility: (Stableprice.where(stable_id: stable.id).order(price_date: :desc).pluck(:natural_log).each {|p| p }).standard_deviation)
            sleep 0.5
          end
        end
        stable.update(risk_volatility: Stableprice.where(stable_id: stable.id).order(price_date: :desc).first.volatility)
      end
    end
  end

  task mim: :environment do
    @days = [90,
             89,88,87,86,85,84,83,82,81,80,
             79,78,77,76,75,74,73,72,71,70,
             69,68,67,66,65,64,63,62,61,60,
             59,58,57,56,55,54,53,51,50,
             49,48,47,46,45,44,43,42,41,40,
             39,38,37,36,35,34,33,32,31,30,
             29,28,27,26,25,24,23,22,21,20,
             19,18,17,16,15,14,13,12,11,10,
             9,8,7,6,5,4,3,2,1]
    @days.each do |d|
      Stable.where(symbol: "MIM").each do |stable|
        if Stableprice.where(stable_id: stable.id, price_date: (Time.now - d.day).end_of_day).exists?
          puts "Skipping " + stable.symbol + ". Prices for " + (Time.now - d.days).strftime("%b %d, %Y") + " already in database."
        else
          puts "Adding closing price for " + stable.symbol + " for " + (Time.now - d.days).beginning_of_day.to_s
          if d == 90
            url = "https://coins.llama.fi/prices/historical/" + ((Time.now - (d.days)).end_of_day.to_i).to_s + "/" + stable.gecko_id + ":" + stable.contract_address
            uri = URI(url)
            response = Net::HTTP.get(uri)
            closing = JSON.parse(response)
            url2 = "https://coins.llama.fi/prices/historical/" + ((Time.now - ((d + 1).days)).end_of_day.to_i).to_s + "/" + stable.gecko_id + ":" + stable.contract_address
            uri2 = URI(url2)
            response2 = Net::HTTP.get(uri2)
            closing2 = JSON.parse(response2)
            Stableprice.create(
              asset: stable.asset,
              stable_id: stable.id,
              closing_price: closing["coins"]["#{stable.gecko_id}:#{stable.contract_address}"]["price"].to_d,
              price_date: (Time.now - d.days).end_of_day,
              natural_log: Math.log((closing2["coins"]["#{stable.gecko_id}:#{stable.contract_address}"]["price"]).to_d/(closing["coins"]["#{stable.gecko_id}:#{stable.contract_address}"]["price"]).to_d),
              volatility: "0.00 ")
              sleep 3
          else
            url = "https://coins.llama.fi/prices/historical/" + ((Time.now - (d.days)).end_of_day.to_i).to_s + "/" + stable.gecko_id + ":" + stable.contract_address
            uri = URI(url)
            response = Net::HTTP.get(uri)
            closing = JSON.parse(response)
            Stableprice.create(
              asset: stable.asset,
              stable_id: stable.id,
              closing_price: closing["coins"]["#{stable.gecko_id}:#{stable.contract_address}"]["price"].to_d,
              price_date: (Time.now - d.days).end_of_day,
              natural_log: Math.log(Stableprice.where(stable_id: stable.id).order(price_date: :desc).last.closing_price.to_d/(closing["coins"]["#{stable.gecko_id}:#{stable.contract_address}"]["price"]).to_d))
            sleep 1
            stable.stableprices.last.update(
              volatility: (Stableprice.where(stable_id: stable.id).order(price_date: :desc).pluck(:natural_log).each {|p| p }).standard_deviation)
            sleep 0.5
          end
        end
        stable.update(risk_volatility: Stableprice.where(stable_id: stable.id).order(price_date: :desc).first.volatility)
      end
    end
  end

  task susd: :environment do
    @days = [90,
             89,88,87,86,85,84,83,82,81,80,
             79,78,77,76,75,74,73,72,70,
             69,68,67,66,65,64,63,62,61,60,
             59,58,57,56,55,54,53,52,51,50,
             49,48,47,46,45,44,43,42,41,40,
             39,38,37,36,35,34,33,32,31,30,
             29,28,27,26,25,24,23,22,21,20,
             19,18,17,16,15,14,13,12,11,10,
             9,8,7,6,5,4,3,2,1]
    @days.each do |d|
      Stable.where(symbol: "sUSD").each do |stable|
        if Stableprice.where(stable_id: stable.id, price_date: (Time.now - d.day).end_of_day).exists?
          puts "Skipping " + stable.symbol + ". Prices for " + (Time.now - d.days).strftime("%b %d, %Y") + " already in database."
        else
          puts "Adding closing price for " + stable.symbol + " for " + (Time.now - d.days).beginning_of_day.to_s
          if d == 90
            url = "https://coins.llama.fi/prices/historical/" + ((Time.now - (d.days)).end_of_day.to_i).to_s + "/" + stable.gecko_id + ":" + stable.contract_address
            uri = URI(url)
            response = Net::HTTP.get(uri)
            closing = JSON.parse(response)
            url2 = "https://coins.llama.fi/prices/historical/" + ((Time.now - ((d + 1).days)).end_of_day.to_i).to_s + "/" + stable.gecko_id + ":" + stable.contract_address
            uri2 = URI(url2)
            response2 = Net::HTTP.get(uri2)
            closing2 = JSON.parse(response2)
            Stableprice.create(
              asset: stable.asset,
              stable_id: stable.id,
              closing_price: closing["coins"]["#{stable.gecko_id}:#{stable.contract_address}"]["price"].to_d,
              price_date: (Time.now - d.days).end_of_day,
              natural_log: Math.log((closing2["coins"]["#{stable.gecko_id}:#{stable.contract_address}"]["price"]).to_d/(closing["coins"]["#{stable.gecko_id}:#{stable.contract_address}"]["price"]).to_d),
              volatility: "0.00 ")
              sleep 3
          else
            url = "https://coins.llama.fi/prices/historical/" + ((Time.now - (d.days)).end_of_day.to_i).to_s + "/" + stable.gecko_id + ":" + stable.contract_address
            uri = URI(url)
            response = Net::HTTP.get(uri)
            closing = JSON.parse(response)
            Stableprice.create(
              asset: stable.asset,
              stable_id: stable.id,
              closing_price: closing["coins"]["#{stable.gecko_id}:#{stable.contract_address}"]["price"].to_d,
              price_date: (Time.now - d.days).end_of_day,
              natural_log: Math.log(Stableprice.where(stable_id: stable.id).order(price_date: :desc).last.closing_price.to_d/(closing["coins"]["#{stable.gecko_id}:#{stable.contract_address}"]["price"]).to_d))
            sleep 1
            stable.stableprices.last.update(
              volatility: (Stableprice.where(stable_id: stable.id).order(price_date: :desc).pluck(:natural_log).each {|p| p }).standard_deviation)
            sleep 0.5
          end
        end
        stable.update(risk_volatility: Stableprice.where(stable_id: stable.id).order(price_date: :desc).first.volatility)
      end
    end
  end

end
