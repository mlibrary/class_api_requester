## Installation

Add this line to your application's Gemfile:

```ruby
gem 'class_api_requester'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install class_api_requester

## Usage
Creation, for example to access the ClassSchedule API:

```ruby
@api = ClassAPIRequester.new( MY_API_ID,
                           MY_API_SECRET,
                           API_URL,
                           'umscheduleofclasses',
                           API_TOKEN_URL)
```

Send request to get Terms:
```ruby
response = @api.sendRequest('')
```

Send request to get Schools:
```ruby
response = @api.sendRequest('/' + termcode + "/Schools")
```
