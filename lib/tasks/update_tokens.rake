require 'task_helpers/tokens_helper'

namespace :update_tokens do
  desc 'Update tokens with latest Coingecko data'
  task marketcap: :environment do
    Token.all.each do |token|
      CoingeckoRuby::Client.new.markets(token.asset, vs_currency: 'usd').each do |datum|
        token.update(risk_marketcap: datum['market_cap'].to_f)
      end
    end
  end
  task volume: :environment do
    Token.all.each do |token|
      CoingeckoRuby::Client.new.markets(token.asset, vs_currency: 'usd').each do |datum|
        token.update(risk_volume: datum['total_volume'].to_f)
      end
    end
  end

  task grade: :environment do
    Token.all.each do |token|
      token.update(grade: TokensHelper.overall_score(token))
    end
  end
end
