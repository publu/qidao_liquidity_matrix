require 'task_helpers/tokens_helper'

namespace :update_tokens do
  desc 'Update tokens with latest Coingecko data'
  task marketcap: :environment do
    Token.all.each do |token|
      CoingeckoRuby::Client.new.markets(token.asset, vs_currency: 'usd').each do |datum|
        token.update(risk_marketcap: datum['market_cap'].to_f)
        puts "Marketcap for " + token.symbol + " (" + token.network.name + ") has been updated."
        sleep 0.25
      end
    end
    puts "Marketcap update completed."
  end
  task volume: :environment do
    Token.all.each do |token|
      CoingeckoRuby::Client.new.markets(token.asset, vs_currency: 'usd').each do |datum|
        token.update(risk_volume: datum['total_volume'].to_f)
        puts "Volume for " + token.symbol + " (" + token.network.name + ") has been updated."
        sleep 0.25
      end
    end
    puts "Volume update completed."
  end

  task grade: :environment do
    Token.all.each do |token|
      token.update(grade: TokensHelper.overall_score(token))
      puts "Risk grading for " + token.symbol + " (" + token.network.name + ") has been updated."
      sleep 0.25
    end
    puts "Risk grading update completed."
  end

  task debts: :environment do
    Token.where.not(vault_address: '').where(minter_id: 1).each do |token|
      url = 'https://api.mai.finance/v2/vaultIncentives'
      uri = URI(url)
      response = Net::HTTP.get(uri)
      vaults = JSON.parse(response)
      vaults.each do |vault|
        vault.second.each do |v|
          if v["vaultAddress"] == token.vault_address
            token.update(mai_debt: v["totalQualifyingDebt"])
            puts "Debt for " + token.symbol + " (" + token.network.name + ") has been updated."
            sleep 0.25
          end
        end
      end
    end
    puts "MAI debt update completed."
  end

end
