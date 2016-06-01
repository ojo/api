update:
	ansible-playbook playbooks/update.yml

provision: roles/redis/files/redis-3.2.0.tar.gz
	ansible-playbook provision.yml
	
roles/redis/files/redis-3.2.0.tar.gz:
	wget http://download.redis.io/releases/redis-3.2.0.tar.gz -P roles/redis/files
