class CsvImportMintersService
  require 'csv'

  def call(file)
    file = File.open(file)
    csv = CSV.parse(file, headers: true, col_sep: ',')
    csv.each do |row|
      minter_hash = row.to_hash
      Minter.find_or_create_by(id: minter_hash['id']).update(minter_hash)
    end
  end
end
