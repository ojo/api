.PHONY: test
test:
	bundle exec rake db:test:prepare
	bin/rails test

run:
	bundle exec foreman start

# NB: Get Envfile from @btc
creds: Envfile
	bin/dotenvgen
	./.elasticbeanstalk/setenv.py .env.production .env.web
	./.elasticbeanstalk/setenv.py --env workers .env.production
