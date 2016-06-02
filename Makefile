.PHONY: test
test:
	bundle exec rake db:test:prepare
	bin/rails test

run:
	bundle exec foreman start

update:
	ansible-playbook ops/playbooks/update.yml
	ansible-playbook ops/playbooks/init_postgresql_db.yml

