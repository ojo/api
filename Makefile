test:
	bundle exec rake db:test:prepare
	bundle exec rspec

run:
	bundle exec foreman start
