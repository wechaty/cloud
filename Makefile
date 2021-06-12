# Makefile for Wechaty cloud microservices orchestration
#
# 	GitHb: https://github.com/wechaty/cloud
# 	Author: Huan LI <zixia@zixia.net> https://github.com/huan
#

SOURCE_GLOB=$(wildcard manifests/**/*.yaml)

.PHONY: all
all : clean lint

.PHONY: clean
clean:
	rm -fr dist/* .pytype

.PHONY: install
install:
	bash -x ./scripts/install.sh

.PHONY: lint
lint: stein

.PHONY: stein
stein:
	stein apply $(SOURCE_GLOB)

.PHONY: version
version:
	@newVersion=$$(awk -F. '{print $$1"."$$2"."$$3+1}' < VERSION) \
		&& echo $${newVersion} > VERSION \
		&& echo VERSION = \'$${newVersion}\' > src/wechaty/version.py \
		&& git add VERSION src/wechaty/version.py \
		&& git commit -m "🔥 update version to $${newVersion}" > /dev/null \
		&& git tag "v$${newVersion}" \
		&& echo "Bumped version to $${newVersion}"

.PHONY: deploy-version
deploy-version:
	echo "VERSION = '$$(cat VERSION)'" > src/wechaty/version.py
