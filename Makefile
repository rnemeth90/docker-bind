MAINTAINER=rnemeth90
PROJECT=docker-bind
VERSION=1.0.0


all: build

build:
	@docker build --tag=${MAINTAINER}/${PROJECT}:${VERSION} .
	@docker build --tag=${MAINTAINER}/${PROJECT}:latest .

push:
	@docker push ${MAINTAINER}/${PROJECT}:${VERSION}
	@docker push ${MAINTAINER}/${PROJECT}:latest

docker-run-primary:
	@docker run --rm --name bind -d --publish 53:53/tcp --publish 53:53/udp --volume ${PWD}/example/primary:/data ${MAINTAINER}/${PROJECT}

docker-run-secondary:
	@docker run --rm --name bind -d --publish 53:53/tcp --publish 53:53/udp --volume ${PWD}/example/secondary:/data ${MAINTAINER}/${PROJECT}

docker-stop:
	@docker stop bind

create-key:
	@docker exec -it bind create-key ${ZONE}