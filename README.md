# offline_bank

## Introduction

This gem uses a static exchange rate cached from the European Central Bank. You can use it when you don't have a working internet connection.

## Installation

```
gem install offline_bank
```

## Dependencies

- nokogiri
- money

## Usage

With the gem, you do not need to manually add exchange rates. Calling update_rates will use a cached version of actual rates from the European Central Bank. The API is the same as the money gem. Feel free to use Money objects with the bank.


``` ruby
offline_bank = OfflineBank.new
Money.default_bank = offline_bank
money1 = Money.new(10)
money1.bank # offline_bank

# exchange 100 CAD to USD
# API is the same as the money gem
offline_bank.exchange(100, "CAD", "USD") # Money.new(80, "USD")
Money.us_dollar(100).exchange_to("CAD")  # Money.new(124, "CAD")

# using the new exchange_with method
offline_bank.exchange_with(Money.new(100, "CAD"), "USD") # Money.new(80, "USD")
```

## Note on Patches/Pull Requests

- Fork the project.
- Make your feature addition or bug fix.
- Add tests for it. This is important so I don't break it in a  future version unintentionally.
- Commit, do not mess with rakefile, version, or history. (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)

## Copyright

Copyright (c) 2010-2013 RubyMoney. See LICENSE for details.
