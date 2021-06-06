build:
	docker-compose build

console:
	docker-compose run --rm analysis bin/console

db-up:
	docker-compose up -d postgres redis

db-down:
	docker-compose stop postgres redis

test.build:
	docker-compose --file docker-compose.test.yml build && \
	  make test.prepare

test.prepare:
	docker-compose --file docker-compose.test.yml run --rm web rails db:create db:migrate && \
	  docker-compose --file docker-compose.test.yml run --rm analysis yarn && \
	  docker-compose --file docker-compose.test.yml run --rm analysis-node yarn

test:
	docker-compose --file docker-compose.test.yml run --rm web rspec && \
	  docker-compose run --rm analysis yarn --non-interactive test && \
	  docker-compose run --rm analysis-node yarn --non-interactive test

bash:
	docker-compose run --rm analysis bash
