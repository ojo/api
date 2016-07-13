.PHONY: test
test:
	bundle exec rake db:test:prepare
	bin/rails test

run:
	bundle exec foreman start

update:
	ansible-playbook ops/playbooks/update.yml
	ansible-playbook ops/playbooks/init_postgresql_db.yml

deploy:
	bundle exec cap production deploy

# NB: Get Envfile from @btc
creds: Envfile
	bin/dotenvgen
	./.elasticbeanstalk/setenv.py .env.production .env.web
	./.elasticbeanstalk/setenv.py --env workers .env.production
