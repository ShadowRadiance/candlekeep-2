require 'csv'

class CsvImporter
  def initialize(filename=nil)
    @filename = filename || File.join(Rails.root, 'db', 'library.csv')
  end

  def fake_import
    # Title,Author,Genre,SubGenre,Pages,Publisher,Copies
    Book.transaction do
      existing_counts = [Book.count, Copy.count]
      import_counts = import
      check_import(existing_counts[0] + import_counts[0],
                   existing_counts[1] + import_counts[1])
      raise ActiveRecord::Rollback
    end
    puts "Import checks out OK"
  end

  def check_import(expected_books, expected_copies)
    raise 'unexpected number of books' if Book.count != expected_books
    raise 'unexpected number of copies' if Copy.count != expected_copies
  end

  def import
    imported = [0,0]
    CSV.foreach(@filename, options) do |row|
      create_book_with_copies(book_params(row), row['Copies'])
      imported[0] += 1
      imported[1] += row['Copies']
    end
    puts "Imported a total of #{imported[1]} copies" \
           " over #{imported[0]} books"
    imported
  end

  def book_params(row)
    {
      title: row['Title'],
      author: row['Author'],
      genre: row['Genre'],
      subgenre: row['SubGenre'],
      pages: row['Pages'],
      publisher: row['Publisher']
    }
  end

  def create_book_with_copies(params, copies)
    create_book(params).tap do |book|
      create_copies(book, copies)
    end
  end

  def create_book(params)
    Book.create(params)
  end

  def create_copies(book, copies)
    copies.times { book.copies.create }
  end

  def options
    {
      headers: true,
      return_headers: false,
      converters: :numeric
    }
  end
end

# Usage
#
# require 'csv_importer'
# imp = CsvImporter.new
# - or -
# imp = CsvImporter.new(file_path)
#
# imp.fake_import
# - or -
# imp.import

