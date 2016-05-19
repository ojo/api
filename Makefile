test:
	bundle exec rake db:test:prepare
	bin/rails test

run:
	bundle exec foreman start
