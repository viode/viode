# Viode [![Build Status](https://img.shields.io/travis/viode/viode.svg)](https://travis-ci.org/viode/viode) [![Code Climate](https://img.shields.io/codeclimate/github/viode/viode.svg)](https://codeclimate.com/github/viode/viode) [![Join the chat at https://gitter.im/viode/viode](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/viode/viode)

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

Requirements: Ruby 1.9+, PostgreSQL, GraphicsMagick (or ImageMagick), Elasticsearch.  
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

**Join the team!**

We are looking for new team members. Regardless of where you are and how much you
know about programming, If you are interested, please
[apply](https://docs.google.com/forms/d/19hvjOVyRD06blr2hmrKOVj6SGKwt8AkgBFqtFiP3nrI/viewform).

## License

Released under the BSD 2-clause license. See LICENSE.txt for details.

![built-with-ruby](http://forthebadge.com/images/badges/built-with-ruby.svg)
![built-with-love](http://forthebadge.com/images/badges/built-with-love.svg)
