BUILD_TAG=leochan007/eos

ifdef VER
	BUILD_TAG=$(BUILD_TAG):$(VER)
endif

EXTRA=
ifdef R
	EXTRA="--no-cache"
endif

build:
	docker build -t $(BUILD_TAG) $(EXTRA) -f Dockerfile .

push:
	docker push $(BUILD_TAG)

all: build push
