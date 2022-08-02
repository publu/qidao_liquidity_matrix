class CsvImportNetworksService
  require 'csv'

  def call(file)
    file = File.open(file)
    csv = CSV.parse(file, headers: true, col_sep: ',')
    csv.each do |row|
      network_hash = {}
      network_hash[:name] = row['name']
      network_hash[:color] = row['color']
      network_hash[:blockchain_explorer] = row['blockchain_explorer']
      Network.find_or_create_by!(network_hash)
    end
  end
end
