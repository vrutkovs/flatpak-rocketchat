all:
	npm install
	node_modules/.bin/gulp build --env=production

install:
	rm -rf build/images/{osx,windows}
	mkdir -p /app/share/rocketchat
	cp -r * /app/share/rocketchat

	echo "#!/bin/bash" > /app/bin/rocketchat
	echo 'cd /app/share/rocketchat && npm start' >> /app/bin/rocketchat
	chmod +x /app/bin/rocketchat


.PHONY: all install
