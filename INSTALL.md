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

7. Add data to the search index:

  ```sh
  rake searchkick:reindex:all
  ```

  Now you can start the server: `rails s`.

## Installation on Heroku

Create a new branch called `heroku`:

```sh
git checkout -b heroku
```

Copy and add `secrets.yml` file to git:

```sh
cp config/secrets.yml.example config/secrets.yml
git add -f config/secrets.yml
git commit -m "add secrets.yml for heroku"
```

Push `heroku` branch to heroku:

```sh
git push heroku heroku:master
```

Set ruby version:

```sh
heroku config:set VIODE_RUBY_VERSION=2.2.2
```

Set devise secret key:

```sh
heroku config:set DEVISE_SECRET_KEY=`rake secret`
```

Run database migrations:

```sh
heroku run rake db:migrate
```

Add Elasticsearch add-on and set `ENV["ELASTICSEARCH_URL"]`:

```sh
heroku addons:add bonsai:starter
heroku config:add ELASTICSEARCH_URL=`heroku config:get BONSAI_URL`
```

Add data to the search index:

```sh
heroku run rake searchkick:reindex:all
```
