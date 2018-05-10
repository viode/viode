# Viode [![wercker status](https://app.wercker.com/status/daf9e5e93d529ec0e3435fc36c4347d4/s/master "wercker status")](https://app.wercker.com/project/byKey/daf9e5e93d529ec0e3435fc36c4347d4) [![Code Climate](https://img.shields.io/codeclimate/maintainability/viode/viode.svg)](https://codeclimate.com/github/viode/viode)

Viode is an open source Q&A _(question and answer)_ community platform built
with Ruby on Rails.

## Features

+ Categories
+ Category subscriptions
+ Labels (tags)
+ Ask and answer questions
+ Anonymous questions and answers
+ Votes for questions and answers
+ Search questions and labels
+ User access levels (groups)
+ User points (reputation)
+ Star questions (bookmark)
+ SEO friendly
+ Can be used as a discussion board
+ And [many more](https://github.com/viode/viode/labels/feature).. Stay tuned.

## Installation

Requirements: Ruby 1.9+, PostgreSQL, GraphicsMagick (or ImageMagick).  
System requirements: In several installations, Viode performs well on 512MB
Linux (CentOS) instance and 128MB FreeBSD instance. Your mileage may vary.

See [INSTALL.md](https://github.com/viode/viode/blob/master/INSTALL.md) for
detailed installation guide.

## Points

Viode has a user points system (aka user reputation). You can configure it by
editing `config/secrets.yml` file.  

Here are the basics of the system:

* Each new user gets 100 points
* User gets 2 points when his question gets starred
* User gets 10 points when his answer or question gets upvoted
* User loses 10 points when his answer or question gets downvoted

## Contributing

See
[CONTRIBUTING.md](https://github.com/viode/viode/blob/master/CONTRIBUTING.md)
for contribution guides.

## License

Released under the BSD 2-clause license. See LICENSE.txt for details.
