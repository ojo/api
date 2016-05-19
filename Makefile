test:
	bundle exec rake db:test:prepare
	bundle exec rake spec

run:
	bundle exec foreman start
