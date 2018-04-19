require 'csv'

class CsvImporter
  def initialize(filename=nil)
    @filename = filename || File.join(Rails.root, 'db', 'library.csv')

    reset_counts
  end

  def fake_import
    # Library,Title,Author,Genre,SubGenre,Pages,Publisher,Copies
    Book.transaction do
      import
      raise ActiveRecord::Rollback
    end
    puts 'Import checks out OK'
  end

  def import
    reset_counts
    CSV.foreach(@filename, options) do |row|
      branch = find_or_create_branch(row['Library'])
      book = find_or_create_book(book_params(row))
      create_copies(book, row['Copies'], branch)
    end
    report_counts
  end

  private

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

  def find_or_create_branch(branch_name)
    Branch.find_or_create_by!(name: branch_name) do
      @branches_created += 1
    end
  end

  def find_or_create_book(params)
    book = Book.find_or_create_by(params) do
      @books_created += 1
    end
    unless book.valid?
      raise "Failed to import book with params #{params.as_json}: \n#{book.errors.full_messages.to_sentence}"
    end
    book
  end

  def create_copies(book, copies, branch)
    copies.times do
      book.copies.create!(branch: branch)
      @copies_created += 1
    end
  end

  def options
    {
      headers: true,
      return_headers: false,
      converters: :numeric
    }
  end

  def report_counts
    puts 'Imported a total of ' \
           " #{@copies_created} copies" \
           " over #{@books_created} books" \
           " and #{@branches_created} branches"
  end

  def reset_counts
    @copies_created = 0
    @books_created = 0
    @branches_created = 0
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

