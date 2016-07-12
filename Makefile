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

updotenv:
	aws s3 cp .env.production s3://ttrn-api-util/.env.production
