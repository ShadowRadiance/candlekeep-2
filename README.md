# Candlekeep

Library Book Application

Running on https://stark-chamber-52048.herokuapp.com/

## Development Setup

### Importing CSV Data

**Important**: importing data removes and replaces all books in the system.
Existing checkout history will be voided.

If running locally, you can import data by placing your CSV file into 
`db/library.csv` and running one of:

```
rake importer:clean_import # Clear books related data, then Imports db/library.csv file into the database
rake importer:fake_import  # fakes importing db/library.csv file into the database
```

The CSV should have a header row as follows:

```
Title,Author,Genre,SubGenre,Pages,Publisher,Copies
```

#### Potential Future Enhancements

An administrator will have a button on the books screen to upload a CSV 
which will be parsed and added to the database.
The processed file will be previewed before being applied.
