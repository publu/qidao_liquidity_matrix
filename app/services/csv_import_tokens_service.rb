class CsvImportTokensService
  require 'csv'

  def call(file)
    file = File.open(file)
    csv = CSV.parse(file, headers: true, col_sep: ',')
    csv.each do |row|
      token_hash = {}
      token_hash[:asset] = row['asset']
      token_hash[:symbol] = row['symbol']
      token_hash[:liquidity] = row['liquidity']
      token_hash[:trade_slippage] = row['trade_slippage']
      token_hash[:volume] = row['volume']
      token_hash[:centralized] = row['centralized']
      token_hash[:network_id] = row['network_id']
      token_hash[:coingecko] = row['coingecko']
      token_hash[:coinmarketcap] = row['coinmarketcap']
      token_hash[:contract_address] = row['contract_address']
      token_hash[:contract_days] = row['contract_address']
      token_hash[:contract_transactions] = row['contract_transactions']
      token_hash[:holders] = row['holders']
      token_hash[:permissions] = row['permissions']
      token_hash[:risk_marketcap] = row['risk_marketcap']
      token_hash[:risk_volume] = row['risk_volume']
      token_hash[:risk_volatility] = row['risk_volatility']
      Token.find_or_create_by!(token_hash)
    end
  end
end
