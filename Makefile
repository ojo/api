.PHONY: test
test:
	bundle exec rake db:test:prepare
	bin/rails test
	bundle exec rspec

run:
	bundle exec foreman start
