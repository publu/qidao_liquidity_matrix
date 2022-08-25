module TokensHelper

    def sort_link(column:, label:)
      if column == "symbol"
        link_to(label, tokens_path(column: column, direction: next_direction), title: "Sort tokens")
      elsif column != "symbol"
        if column == params[:column]
          link_to(label, tokens_path(column: column, direction: next_direction), title: "Sort tokens")
        else
          link_to(label, tokens_path(column: column, direction: 'desc'), title: "Sort tokens")
        end
      else
        link_to(label, tokens_path(column: column, direction: 'desc'), title: "Sort tokens")
      end
    end

    def next_direction
      params[:direction] == 'asc' ? 'desc' : 'asc'
    end

    def sort_indicator
      tag.span(class: "sort sort-#{params[:direction]}")
    end

    def mai(number)
      number_to_currency(number / (10**18))
    end

    def risk_grade(token)
      risk_average = ((token.contract_days.to_f + token.contract_transactions.to_f)/2)
      if risk_average >= 500000000
        "97"
      elsif risk_average >= 100000000
        "94"
      elsif risk_average >= 10000000
        "90"
      elsif risk_average >= 1000000
        "87"
      elsif risk_average >= 350000
        "84"
      elsif risk_average >= 100000
        "77"
      elsif risk_average >= 25000
        "70"
      elsif risk_average >= 0
        "65"
      else
       "Error"
      end
    end

    def holder_grade(token)
      if token.holders.to_f >= 100000000
        "97"
      elsif token.holders.to_f >= 1000000
        "94"
      elsif token.holders.to_f >= 500000
        "90"
      elsif token.holders.to_f >= 100000
        "87"
      elsif token.holders.to_f >= 50000
        "84"
      elsif token.holders.to_f >= 25000
        "80"
      elsif token.holders.to_f >= 10000
        "77"
      elsif token.holders.to_f >= 2500
        "70"
      elsif token.holders.to_f >= 0
        "65"
      else
       "Error"
      end
    end

    def permissions_grade(token)
      if token.permissions == "ETH"
        "97"
      elsif token.permissions == "Centralized but regulated"
        "94"
      elsif token.permissions == "Permissionless"
        "87"
      elsif token.permissions == "Centralized real time PoF"
        "80"
      elsif token.permissions == "Some controlling functions"
        "74"
      elsif token.permissions == "Some controll over minting"
        "70"
      elsif token.permissions == "Centralized with audit"
        "67"
      elsif token.permissions == "Centralized"
        "65"
      elsif token.permissions == "Opaque"
        "60"
      else
       "Error"
      end
    end

    def marketcap_grade(token)
      if token.risk_marketcap.to_f >= 14900000000
        "97"
      elsif token.risk_marketcap.to_f >= 10000000000
        "94"
      elsif token.risk_marketcap.to_f >= 500000000
        "90"
      elsif token.risk_marketcap.to_f >= 250000000
        "84"
      elsif token.risk_marketcap.to_f >= 100000000
        "80"
      elsif token.risk_marketcap.to_f >= 50000000
        "77"
      elsif token.risk_marketcap.to_f >= 30000000
        "74"
      elsif token.risk_marketcap.to_f >= 15000000
        "70"
      elsif token.risk_marketcap.to_f >= 10000000
        "67"
      elsif token.risk_marketcap.to_f >= 5000000
        "64"
      elsif token.risk_marketcap.to_f >= 0
        "60"
      else
       "Error"
      end
    end

    def volume_grade(token)
      if token.risk_volume.to_f >= 20000000000
        "97"
      elsif token.risk_volume.to_f >= 10000000000
        "94"
      elsif token.risk_volume.to_f >= 2500000000
        "90"
      elsif token.risk_volume.to_f >= 500000000
        "87"
      elsif token.risk_volume.to_f >= 100000000
        "80"
      elsif token.risk_volume.to_f >= 20000000
        "77"
      elsif token.risk_volume.to_f >= 5000000
        "74"
      elsif token.risk_volume.to_f >= 1000000
        "70"
      elsif token.risk_volume.to_f >= 500000
        "67"
      elsif token.risk_volume.to_f >= 250000
        "64"
      elsif token.risk_volume.to_f >= 0
        "60"
      else
       "Error"
      end
    end

    def volatility_grade(token)
      if token.risk_volatility >= 0.139
        "65"
      elsif token.risk_volatility >= 0.124
        "67"
      elsif token.risk_volatility >= 0.109
        "70"
      elsif token.risk_volatility >= 0.094
        "74"
      elsif token.risk_volatility >= 0.079
        "77"
      elsif token.risk_volatility >= 0.064
        "80"
      elsif token.risk_volatility >= 0.051
        "84"
      elsif token.risk_volatility >= 0.038
        "87"
      elsif token.risk_volatility >= 0.025
        "90"
      elsif token.risk_volatility >= 0.015
        "94"
      elsif token.risk_volatility >= 0.005
        "97"
      else
        "60"
      end
    end

    def num_to_grade(number)
      if number >= 97
        "A+"
      elsif number >= 94
        "A"
      elsif number >= 90
        "A-"
      elsif number >= 87
        "B+"
      elsif number >= 84
        "B"
      elsif number >= 80
        "B-"
      elsif number >= 77
        "C+"
      elsif number >= 74
        "C"
      elsif number >= 70
        "C-"
      elsif number >= 67
        "D+"
      elsif number >= 64
        "D"
      elsif number >= 0
        "D-"
      else
       "Error"
      end
    end

    def grade_to_number(grade)
      if grade == "A+"
        "97"
      elsif grade == "A"
        "94"
      elsif grade == "A-"
        "90"
      elsif grade == "B+"
        "87"
      elsif grade == "B"
        "84"
      elsif grade == "B-"
        "80"
      elsif grade == "C+"
        "77"
      elsif grade == "C"
        "74"
      elsif grade == "C-"
        "70"
      elsif grade == "D+"
        "67"
      elsif grade == "D"
        "64"
      elsif grade == "D-"
        "60"
      else
       "Error"
      end
    end

    def counterparty_grade(token)
      num_to_grade((holder_grade(token).to_f + permissions_grade(token).to_f)/2)
    end

    def market_grade(token)
      num_to_grade((marketcap_grade(token).to_f + volume_grade(token).to_f + volatility_grade(token).to_f)/3)
    end

    def overall_score(token)
      num_to_grade((risk_grade(token).to_f + ((holder_grade(token).to_f + permissions_grade(token).to_f)/2) + ((marketcap_grade(token).to_f + volume_grade(token).to_f + volatility_grade(token).to_f)/3))/3)
    end

end
