require 'csv_importer'

namespace :importer do


  desc 'fakes importing db/library.csv file into the database'
  task fake_import: :environment do
    CsvImporter.new.fake_import
  end

  desc 'Clear books related data, then Imports db/library.csv file into the database'
  task clean_import: :environment do
    # Checkout.delete_all
    Copy.delete_all
    Book.delete_all
    CsvImporter.new.import
  end

end
