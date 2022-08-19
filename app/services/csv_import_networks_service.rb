class CsvImportNetworksService
  require 'csv'

  def call(file)
    file = File.open(file)
    csv = CSV.parse(file, headers: true, col_sep: ',')
    csv.each do |row|
      network_hash = row.to_hash
      Network.find_or_create_by(id: network_hash['id']).update(network_hash)
    end
  end
end
