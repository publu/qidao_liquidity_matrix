require 'open-uri'
require 'nokogiri'
require 'task_helpers/tokens_helper'

namespace :tokens do
  desc 'Update tokens with latest data'

  task days: :environment do
    Token.all.each do |token|
      puts "Updating contract days for " + token.symbol + " (" + token.network.name + ")"
      token.update(contract_days: (token.contract_days + 1))
      puts "Completed."
    end
    puts "Contract days update completed."
  end

  task holders_eth: :environment do
    Token.order(id: :asc).each do |token|
      if token.network.chain_id == "1"
        url = token.network.blockchain_explorer + token.contract_address.downcase
        document = URI.open(url)
        content = document.read
        parsed_content = Nokogiri::HTML(content)
        parsed_content.css('#ContentPlaceHolder1_tr_tokenHolders').css('.row').each do |row|
            holders = row.css('.mr-3').first.inner_text
            h = holders.gsub(/\b\s\([^)]*\W/, '').to_s
            token.update(holders: h.gsub(/\W/, ''))
            puts "Updating holders for " + token.symbol + " (" + token.network.name + ")"
            sleep 0.25
        end
      end
    end
  end

  task holders_optimism: :environment do
    Token.order(id: :asc).each do |token|
      if token.network.chain_id == "10"
        url = token.network.blockchain_explorer + token.contract_address.downcase
        document = URI.open(url)
        content = document.read
        parsed_content = Nokogiri::HTML(content)
        parsed_content.css('#ContentPlaceHolder1_tr_tokenHolders').css('.row').each do |row|
          holders = row.css('.mr-3').first.inner_text
          h = holders.gsub(/\b\s\([^)]*\W/, '').to_s
          token.update(holders: h.gsub(/\W/, ''))
          puts "Updating holders for " + token.symbol + " (" + token.network.name + ")"
          sleep 0.25
        end
      end
    end
  end

  task holders_bnb: :environment do
    Token.order(id: :asc).each do |token|
      if token.network.chain_id == "56"
        url = token.network.blockchain_explorer + token.contract_address.downcase
        document = URI.open(url)
        content = document.read
        parsed_content = Nokogiri::HTML(content)
        parsed_content.css('#ContentPlaceHolder1_tr_tokenHolders').css('.row').each do |row|
          holders = row.css('.mr-3').first.inner_text
          h = holders.gsub(/[^0-9]/, '').to_s
          token.update(holders: h.gsub(/\W/, ''))
          puts "Updating holders for " + token.symbol + " (" + token.network.name + ")"
          sleep 0.25
        end
      end
    end
  end

  task holders_polygon: :environment do
    Token.order(id: :asc).each do |token|
      if token.network.chain_id == "137"
        url = token.network.blockchain_explorer + token.contract_address.downcase
        document = URI.open(url)
        content = document.read
        parsed_content = Nokogiri::HTML(content)
        parsed_content.css('#ContentPlaceHolder1_tr_tokenHolders').css('.row').each do |row|
          holders = row.css('.mr-3').first.inner_text
          h = holders.gsub(/[^0-9]/, '').to_s
          token.update(holders: h.gsub(/\W/, ''))
          puts "Updating holders for " + token.symbol + " (" + token.network.name + ")"
          sleep 0.25
        end
      end
    end
  end

  task holders_fantom: :environment do
    Token.order(id: :asc).each do |token|
      if token.network.chain_id == "250"
        url = token.network.blockchain_explorer + token.contract_address.downcase
        document = URI.open(url)
        content = document.read
        parsed_content = Nokogiri::HTML(content)
        parsed_content.css('#ContentPlaceHolder1_tr_tokenHolders').css('.row').each do |row|
          holders = row.css('.col-md-8').first.inner_text
          h = holders.gsub(/[^0-9]/, '').to_s
          token.update(holders: h.gsub(/\W/, ''))
          puts "Updating holders for " + token.symbol + " (" + token.network.name + ")"
          sleep 0.25
        end
      end
    end
  end

  task holders_moonbeam: :environment do
    Token.order(id: :asc).each do |token|
      if token.network.chain_id == "1284"
        url = token.network.blockchain_explorer + token.contract_address.downcase
        document = URI.open(url)
        content = document.read
        parsed_content = Nokogiri::HTML(content)
        parsed_content.css('#ContentPlaceHolder1_tr_tokenHolders').css('.row').each do |row|
          holders = row.css('.mr-3').first.inner_text
          h = holders.gsub(/[^0-9]/, '').to_s
          token.update(holders: h.gsub(/\W/, ''))
          puts "Updating holders for " + token.symbol + " (" + token.network.name + ")"
          sleep 0.25
        end
      end
    end
  end

  task holders_moonriver: :environment do
    Token.order(id: :asc).each do |token|
      if token.network.chain_id == "1285"
        url = token.network.blockchain_explorer + token.contract_address.downcase
        document = URI.open(url)
        content = document.read
        parsed_content = Nokogiri::HTML(content)
        parsed_content.css('#ContentPlaceHolder1_tr_tokenHolders').css('.row').each do |row|
          holders = row.css('.mr-3').first.inner_text
          h = holders.gsub(/[^0-9]/, '').to_s
          token.update(holders: h.gsub(/\W/, ''))
          puts "Updating holders for " + token.symbol + " (" + token.network.name + ")"
          sleep 0.25
        end
      end
    end
  end

  task holders_arbitrum: :environment do
    Token.order(id: :asc).each do |token|
      if token.network.chain_id == "42161"
        url = token.network.blockchain_explorer + token.contract_address.downcase
        document = URI.open(url)
        content = document.read
        parsed_content = Nokogiri::HTML(content)
        parsed_content.css('#ContentPlaceHolder1_tr_tokenHolders').css('.row').each do |row|
          holders = row.css('.mr-3').first.inner_text
          h = holders.gsub(/[^0-9]/, '').to_s
          token.update(holders: h.gsub(/\W/, ''))
          puts "Updating holders for " + token.symbol + " (" + token.network.name + ")"
          sleep 0.25
        end
      end
    end
  end

  task holders_avalanche: :environment do
    Token.order(id: :asc).each do |token|
      if token.network.chain_id == "43114"
        url = token.network.blockchain_explorer + token.contract_address.downcase
        document = URI.open(url)
        content = document.read
        parsed_content = Nokogiri::HTML(content)
        parsed_content.css('#ContentPlaceHolder1_tr_tokenHolders').css('.row').each do |row|
          holders = row.css('.mr-3').first.inner_text
          h = holders.gsub(/[^0-9]/, '').to_s
          token.update(holders: h.gsub(/\W/, ''))
          puts "Updating holders for " + token.symbol + " (" + token.network.name + ")"
          sleep 0.25
        end
      end
    end
  end

  task marketcap: :environment do
    Token.all.order(network_id: :asc).each do |token|
      CoingeckoRuby::Client.new.markets(token.asset, vs_currency: 'usd').each do |datum|
        puts "Updating marketcap for " + token.symbol + " (" + token.network.name + ")."
        if datum['market_cap'] > 0
          token.update(risk_marketcap: datum['market_cap'].to_f)
          puts "Completed."
          sleep 5
        else
          puts "Skipping " + token.symbol + " (" + token.network.name + ")."
          sleep 1
        end
      end
    end
    puts "Marketcap update completed."
  end

  task volume: :environment do
    Token.all.order(network_id: :asc).each do |token|
      CoingeckoRuby::Client.new.markets(token.asset, vs_currency: 'usd').each do |datum|
        puts "Updating volume for " + token.symbol + " (" + token.network.name + ")."
        if datum['total_volume'] > 0
          token.update(risk_volume: datum['total_volume'].to_f)
          puts "Completed."
          sleep 5
        else
          puts "Skipping " + token.symbol + " (" + token.network.name + ")."
          sleep 1
        end
      end
    end
    puts "Volume update completed."
  end

  task grade: :environment do
    Token.all.order(network_id: :asc).each do |token|
      puts "Updating risk grading for " + token.symbol + " (" + token.network.name + ")."
      token.update(grade: TokensHelper.overall_score(token))
      puts "Completed."
      sleep 1
    end
    puts "Risk grading update completed."
  end

  task debt: :environment do
    Token.where.not(vault_address: '').where(minter_id: 1).each do |token|
      url = 'https://api.mai.finance/v2/vaultDebts'
      uri = URI(url)
      response = Net::HTTP.get(uri)
      vaults = JSON.parse(response)
      vault = vaults.select {|v| v["address"].downcase == token.vault_address.downcase }
      if vault.first.present?
        puts "Updating debt for " + token.symbol + " (" + token.network.name + ")."
        token.update(mai_debt: vault.first["totalDebt"].to_s)
      else
        puts "Skipping " + token.symbol + " (" + token.network.name + ")."
      end
      sleep 1
    end
    puts "MAI debt update completed."
  end

  task incentives: :environment do
    Token.where.not(vault_address: '').where(minter_id: 1).each do |token|
      url = 'https://api.mai.finance/v2/vaultIncentives'
      uri = URI(url)
      response = Net::HTTP.get(uri)
      vaults = JSON.parse(response)
      vaults.each do |vault|
        vault.each do |v|
          if v["vaultAddress"] == token.vault_address
            puts "Updating debt for " + token.symbol + " (" + token.network.name + ")."
            token.update(mai_debt: v["totalQualifyingDebt"])
            puts "Completed."
            sleep 1
          end
        end
      end
    end
    puts "MAI debt update completed."
  end

end
