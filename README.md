# Viode [![Build Status](https://img.shields.io/travis/viode/viode.svg)](https://travis-ci.org/viode/viode) [![Code Climate](https://img.shields.io/codeclimate/github/viode/viode.svg)](https://codeclimate.com/github/viode/viode) [![Join the chat at https://gitter.im/viode/viode](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/viode/viode)

[![Join the chat at https://gitter.im/viode/viode](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/viode/viode?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Open source Q&A _(question and answer)_ community platform built with Ruby on Rails.

## Features

+ Categories
+ Labels (tags)
+ Ask and answer questions
+ Anonymous questions and answers
+ Votes for questions and answers
+ User points (reputation)
+ SEO friendly
+ Can be used as a discussion board
+ And [many more](https://github.com/viode/viode/labels/feature).. Stay tuned.

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

6. Create and seed the database:

  ```sh
  rake db:setup
  ```

  This will create a user with username `admin` and password `12345678`.

  Now you can start the server: `rails s`.

## License

Released under the BSD 2-clause license. See LICENSE.txt for details.
