# DailyProgress

Simple ruby gem to convert my vimwiki diary entry to daily progress email.

## Dependencies

1. `xclip`  - Xclip should be installed for Linux systems as it is used to copy over the final content over 
   to the clipboard.
   
2. Vimwiki should be installed and generate the diary entry in the following format:

```text
To Do Status.
1. [] First Item
2. [] Second Item
3. [] Third Item
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'DailyProgress'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install DailyProgress

## Usage

1. Create your Vimwiki entry for today.
2. Call the executable. By default it looks for the vimwiki at the path `$HOME/vimwiki/diary`
   
```sh
lovepreet@home:~$ DailyProgress
```

If you have it somewhere else, add the file path as an argument to the executable. The path can be relative.

     
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Roadmap

Further, need to add the functionality to copy the result content into the clipboard. Currently the output is to STDOUT.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lovepreetkaul/DailyProgress. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the DailyProgress project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/DailyProgress/blob/master/CODE_OF_CONDUCT.md).
