PHONY: help build run

help:
	@echo 'Available targets:'
	@echo '  make build - build ruby-chatgpt-telegram-bot image'
	@echo '  make run - run ruby-chatgpt-telegram-bot via docker'

build:
	docker build -t ruby-chatgpt-telegram-bot .

run:
	docker run -it -v $(pwd):/app ruby-chatgpt-telegram-bot
