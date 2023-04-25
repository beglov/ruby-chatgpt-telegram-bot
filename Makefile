.PHONY: help build run push

help:
	@echo 'Available targets:'
	@echo '  make build - build image'
	@echo '  make run   - run ChatGPT Telegram bot'
	@echo '  make push  - upload an image to a registry'

build:
	docker build -t ruby-chatgpt-telegram-bot -t gambit10/ruby-chatgpt-telegram-bot .

run:
	docker run -v $(pwd):/app ruby-chatgpt-telegram-bot

push:
	docker push gambit10/ruby-chatgpt-telegram-bot
