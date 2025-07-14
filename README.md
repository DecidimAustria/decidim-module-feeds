# Decidim::Feeds participatory space

This Feeds module adds a simple Feeds Participatory Space to hold a feed component.

<img width="1170" height="2532" alt="IMG_4781" src="https://github.com/user-attachments/assets/9c941507-7e87-4a00-9f23-456ffc442494" />

## Usage

Feeds will be available as a Participatory Space. This space is very simple and currently just a container for posts.

Find more information about posts in the README of the [posts module](https://github.com/DecidimAustria/decidim-module-posts)

It is planned to allow users to create groups for their posts and the groups will be implemented as individual feeds. So users should be able to create new feeds including a posts and meetings component. This is currently partly implemented but not finished.

## Installation

Choose the right version for your Decidim installation:

 - *0.28*: "~> 1.0"
 - *0.29*: "~> 2.0"
 - *0.30*: "~> 3.0"

Add this line to your application's Gemfile:

```ruby
gem "decidim-feeds", "~> 3.0"
```

And then execute:

```bash
bundle
bundle exec rails decidim_feeds:install:migrations
bundle exec rails db:migrate
```

## Contributing

Contributions are welcome !

We expect the contributions to follow the [Decidim's contribution guide](https://github.com/decidim/decidim/blob/develop/CONTRIBUTING.adoc).

## Security

Security is very important to us. If you have any issue regarding security, please disclose the information responsibly by sending an email to __security [at] mitgestalten [dot] jetzt__ and not by creating a Github issue.

## License

This engine is distributed under the GNU AFFERO GENERAL PUBLIC LICENSE.
