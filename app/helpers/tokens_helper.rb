module TokensHelper

    def risk_grade(token)
      average = (token.contract_days + token.contract_transactions)/2
      if average >= 500000000
        "A+"
      elsif average >= 100000000
        "A"
      elsif average >= 10000000
        "A-"
      elsif average >= 1000000
        "B+"
      elsif average >= 350000
        "B"
      elsif average >= 100000
        "C+"
      elsif average >= 25000
        "C-"
      elsif average >= 0
        "D"
      else
       "Error"
      end
    end

    def holder_grade(token)
      if token.holders >= 100000000
        "A+"
      elsif token.holders >= 1000000
        "A"
      elsif token.holders >= 500000
        "A-"
      elsif token.holders >= 100000
        "B+"
      elsif token.holders >= 50000
        "B"
      elsif token.holders >= 25000
        "B-"
      elsif token.holders >= 10000
        "C+"
      elsif token.holders >= 2500
        "C-"
      elsif token.holders >= 0
        "D"
      else
       "Error"
      end
    end

    def permissions_grade(token)
      if token.permissions == "ETH"
        "A+"
      elsif token.permissions == "Centralized but regulated"
        "A"
      elsif token.permissions == "Permissionless"
        "B+"
      elsif token.permissions == "Centralized real time PoF"
        "B-"
      elsif token.permissions == "Some controlling functions"
        "C"
      elsif token.permissions == "Some controll over minting"
        "C-"
      elsif token.permissions == "Centralized with audit"
        "D+"
      elsif token.permissions == "Centralized"
        "D"
      elsif token.permissions == "Opaque"
        "D-"
      else
       "Error"
      end
    end

    def marketcap_grade(token)
      if token.risk_marketcap >= 14900000000
        "A+"
      elsif token.risk_marketcap >= 10000000000
        "A"
      elsif token.risk_marketcap >= 500000000
        "A-"
      elsif token.risk_marketcap >= 250000000
        "B"
      elsif token.risk_marketcap >= 100000000
        "B-"
      elsif token.risk_marketcap >= 50000000
        "C+"
      elsif token.risk_marketcap >= 30000000
        "C"
      elsif token.risk_marketcap >= 15000000
        "C-"
      elsif token.risk_marketcap >= 10000000
        "D+"
      elsif token.risk_marketcap >= 5000000
        "D"
      elsif token.risk_marketcap >= 0
        "D-"
      else
       "Error"
      end
    end

    def volume_grade(token)
      if token.risk_volume >= 20000000000
        "A+"
      elsif token.risk_volume >= 10000000000
        "A"
      elsif token.risk_volume >= 2500000000
        "A-"
      elsif token.risk_volume >= 500000000
        "B"
      elsif token.risk_volume >= 100000000
        "B-"
      elsif token.risk_volume >= 20000000
        "C+"
      elsif token.risk_volume >= 5000000
        "C"
      elsif token.risk_volume >= 1000000
        "C-"
      elsif token.risk_volume >= 500000
        "D+"
      elsif token.risk_volume >= 250000
        "D"
      elsif token.risk_volume >= 0
        "D-"
      else
       "Error"
      end
    end

    def volatility_grade(token)
      if token.risk_volatility >= 0.139
        "D"
      elsif token.risk_volatility >= 0.124
        "D+"
      elsif token.risk_volatility >= 0.109
        "C-"
      elsif token.risk_volatility >= 0.094
        "C"
      elsif token.risk_volatility >= 0.079
        "C+"
      elsif token.risk_volatility >= 0.064
        "B-"
      elsif token.risk_volatility >= 0.051
        "B"
      elsif token.risk_volatility >= 0.038
        "B+"
      elsif token.risk_volatility >= 0.025
        "A-"
      elsif token.risk_volatility >= 0.015
        "A"
      elsif token.risk_volatility >= 0.005
        "A+"
      else
        "D"
      end
    end

end
