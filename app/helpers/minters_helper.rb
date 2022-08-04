module MintersHelper

  def sort_minter_link(column:, label:)
    if column == "symbol"
      link_to(label, minter_path(column: column, direction: next_direction))
    elsif column != "symbol"
      if column == params[:column]
        link_to(label, minter_path(column: column, direction: next_direction))
      else
        link_to(label, minter_path(column: column, direction: 'desc'))
      end
    else
      link_to(label, minter_path(column: column, direction: 'desc'))
    end
  end

end
