## Requirements

- Ruby 1.9
- PostgreSQL
- ImageMagick
- Elasticsearch

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
