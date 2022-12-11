json.array! @stables do |stable|
 json.asset stable.asset
 json.date stable.price_date
 json.closing_price stable.closing_price
 json.natural_log stable.natural_log
 json.volatility stable.volatility
end
