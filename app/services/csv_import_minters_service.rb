class CsvImportMintersService
  require 'csv'

  def call(file)
    file = File.open(file)
    csv = CSV.parse(file, headers: true, col_sep: ',')
    csv.each do |row|
      network_hash = {}
      network_hash[:name] = row['name']
      network_hash[:link] = row['link']
      Network.find_or_create_by!(network_hash)
    end
  end
end
