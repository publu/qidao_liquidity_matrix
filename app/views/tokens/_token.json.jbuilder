json.extract! token, :id, :asset, :symbol, :liquidity, :trade_slippage, :volume, :centralized, :grade, :created_at, :updated_at
json.url token_url(token, format: :json)
