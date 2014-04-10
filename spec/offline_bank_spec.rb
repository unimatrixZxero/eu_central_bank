require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'yaml'

describe OfflineBank do
  before(:each) do
    @bank = OfflineBank.new
    @cache_path = File.expand_path(File.dirname(__FILE__) + '/exchange_rates.xml')
    @illegal_cahce_path = File.expand_path(File.dirname(__FILE__) + '/illegal_exchange_rates.xml')
    @yml_cache_path = File.expand_path(File.dirname(__FILE__) + '/exchange_rates.yml')
    @tmp_cache_path = File.expand_path(File.dirname(__FILE__) + '/tmp/exchange_rates.xml')
    @exchange_rates = YAML.load_file(@yml_cache_path)
  end

  after(:each) do
    if File.exists? @tmp_cache_path
      File.delete @tmp_cache_path
    end
  end

  it "should raise an error if an invalid path is given to save_rates" do
    lambda { @bank.save_rates(nil) }.should raise_exception
  end

  it "should act like it updates itself with exchange rates from ecb" do
    @bank.update_rates
    OfflineBank::CURRENCIES.each do |currency|
      @bank.get_rate("EUR", currency).should > 0
    end
  end

  it "should update itself with exchange rates from cache" do
    @bank.update_rates(@cache_path)
    OfflineBank::CURRENCIES.each do |currency|
      @bank.get_rate("EUR", currency).should > 0
    end
  end

  it "should export to a string a valid cache that can be reread" do
    s = @bank.save_rates_to_s
    @bank.update_rates_from_s(s)
    OfflineBank::CURRENCIES.each do |currency|
      @bank.get_rate("EUR", currency).should > 0
    end
  end

  it 'should set last_updated when the rates faux downloaded' do
    lu1 = @bank.last_updated
    @bank.update_rates(@cache_path)
    lu2 = @bank.last_updated
    @bank.update_rates(@cache_path)
    lu3 = @bank.last_updated

    lu1.should_not eq(lu2)
    lu2.should_not eq(lu3)
  end

  it 'should set rates_updated_at when the rates faux downloaded' do
    lu1 = @bank.rates_updated_at
    @bank.update_rates(@cache_path)
    lu2 = @bank.rates_updated_at

    lu1.should_not eq(lu2)
  end

  it "should return the correct exchange rates using exchange" do
    @bank.update_rates(@cache_path)
    OfflineBank::CURRENCIES.each do |currency|
      subunit_to_unit  = Money::Currency.wrap(currency).subunit_to_unit
      exchanged_amount = @bank.exchange(100, "EUR", currency)
      exchanged_amount.cents.should == (@exchange_rates["currencies"][currency] * subunit_to_unit).round(0).to_i
    end
  end

  it "should return the correct exchange rates using exchange_with" do
    @bank.update_rates(@cache_path)
    OfflineBank::CURRENCIES.each do |currency|
      subunit_to_unit  = Money::Currency.wrap(currency).subunit_to_unit
      amount_from_rate = (@exchange_rates["currencies"][currency] * subunit_to_unit).round(0).to_i

      @bank.exchange_with(Money.new(100, "EUR"), currency).cents.should == amount_from_rate
    end
  end
end
