# Viode

Open source Q&A community platform built with Ruby on Rails.

## Features

+ Categories
+ Labels (tags)
+ Anonymous questions and answers
+ Votes for questions and answers
+ User points (reputation)
+ SEO friendly
+ Can be used as a discussion board

## Installation

1. Clone the repo:

```sh
git clone https://github.com/viode/viode.git
```

**Note**: master branch is always _stable_.

2. Enter project folder:

```sh
cd viode
```

3. Create the `database.yml` file:

```sh
cp config/database.yml.example config/database.yml
```

Update it with your database credentials.

4. Create the `secrets.yml` file:

```sh
cp config/secrets.yml.example config/secrets.yml
```

Adjust as you need.

5. Install dependencies:

```sh
bundle install
```

6. Create and load the database:

```sh
rake db:create db:migrate
```

Now you can start the server.

## License

Released under the BSD 2-clause license. See LICENSE.txt for details.
