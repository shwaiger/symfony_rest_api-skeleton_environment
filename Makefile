up-dev:
	docker-compose --compatibility -f ./docker-compose-common.yml -f ./docker-compose-dev.yml up  --build -d
up-prod:
	docker-compose --compatibility -f ./docker-compose-common.yml -f ./docker-compose-prod.yml up  --build -d

down-dev:
	docker-compose -f ./docker-compose-common.yml  -f ./docker-compose-dev.yml down
down-prod:
	docker-compose -f ./docker-compose-common.yml -f ./docker-compose-prod.yml down

php-bash:
	docker-compose -f ./docker-compose-common.yml exec php bash
php-cron-bash:
	docker-compose -f ./docker-compose-common.yml exec php-cron bash

php-deploy-dev:
	docker-compose -f ./docker-compose-common.yml exec php make deploy-dev

php-setup-dev:
	docker-compose -f ./docker-compose-common.yml exec php make setup-dev
php-setup-cron:
	docker-compose -f ./docker-compose-common.yml exec php-cron make update-crontab

restart-dev: down-dev up-dev

restart-prod: down-prod up-prod

setup-dev: restart-dev php-setup-dev php-deploy-dev php-setup-cron
