.PHONY: up build clean fclean

up:
	docker-compose up -d

build:
	docker-compose build

down:
	docker-compose down

clean:
	docker-compose down -v

fclean: 
	rm -rf /home/amounadi/data/DB/* /home/amounadi/data/WB/*

