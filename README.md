# Candlekeep

Library Book Application

## Heroku

Running on `https://stark-chamber-52048.herokuapp.com/`

Utilizes:

  - Heroku-Postgres::Database (Hobby)
    - for data storage
  - Papertrail (Choklad)
    - for logging
  - Heroku Scheduler (Standard)
    - for scheduling a daily email
  - SendGrid (Starter)
    - for sending email

Poke around the library as a guest, then sign up to access the library as a 
full member! **_You will need to sign up with a real email address as the system 
uses email-verification._** 

Note: if you have a gmail account, you can create as many addresses as you 
like using plus-addressing. If your email is `someone@gmail.com`, you can simply
use an email address such as  `someone+whatever@gmail.com` and it will just 
work and show up in your inbox. (Also useful for finding out who sold your 
email address to a spammer!)

Once you have signed up, you can email me for admin access.

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
