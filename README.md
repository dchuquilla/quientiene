# README

QuienTiene pretend to be an application to interact with car repair companies and car part stores.

It should join as a broadcaster between the actors.

## Technologies
- Ruby 2.7.2
- Ruby on Rails 6.1.4.1
- Rspec 5.1.2
- OneSignal API
- Email SMTP API
- Devise
- Google and Outlook Authorizations

## About Tests
TDD was implemented as a base for refactoring process
### FactoryBot
For TDD newbies, Factory Bot creates db records for testings.
`FactoryBot.create` and other helper classes are shorted to `create` with *FactoryBothMethods* line in `rails_helper.rb` file
#### Methods
- attributes_for
- attributes_for_list
- attributes_for_pair
- build
- build_list
- build_pair
- build_stubbed
- build_stubbed_list
- build_stubbed_pair
- create
- create_list
- create_pair
