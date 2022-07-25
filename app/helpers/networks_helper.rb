module NetworksHelper

  def bc_link(network)
    if network["harmony.one"]
      network.chomp("/address/")
    else
      network.chomp("/token/")
    end
  end

end
