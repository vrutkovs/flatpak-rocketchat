all:
	cd rocketchat && npm install

install:
	mkdir -p /app/rocketchat
	ls -la rocketchat/releases


.PHONY: all install
