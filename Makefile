ifeq ($(FLAG), '')
    FLAG := dev
endif

ifeq ($(STG), '')
    STG := stg
endif

echo 'FLAG:'$(FLAG)
echo 'STG:'$(STG)

.IGNORE: local_update build push clean

local_update:
	cd aci-backend/ && yarn add ../aci-commons
	cd aci-demux-backend/ && yarn add ../aci-commons

build:
	cd aci-backend/ && ./gen_img.sh $(FLAG) $(STG)
	cd aci-frontend/ && ./gen_img.sh $(FLAG) $(STG)
	cd aci-blockchain-updater/ && ./gen_img.sh $(FLAG) $(STG)
	cd aci-reporter/ && ./gen_img.sh $(FLAG) $(STG)

push:
	cd aci-backend/ && ./push_img.sh $(FLAG) $(STG)
	cd aci-frontend/ && ./push_img.sh $(FLAG) $(STG)
	cd aci-blockchain-updater/ && ./push_img.sh $(FLAG) $(STG)
	cd aci-reporter/ && ./push_img.sh $(FLAG) $(STG)

all: build push

backend:
	cd aci-backend/ && ./gen_img.sh $(FLAG) $(STG)
	#cd aci-backend/ && ./push_img.sh $(FLAG) $(STG)

demux:
	cd aci-demux-backend/ && ./gen_img.sh $(FLAG) $(STG)
	cd aci-demux-backend/ && ./push_img.sh $(FLAG) $(STG)

updater:
	cd aci-blockchain-updater/ && ./gen_img.sh $(FLAG) $(STG)
	cd aci-blockchain-updater/ && ./push_img.sh $(FLAG) $(STG)

reporter:
	cd aci-reporter/ && ./gen_img.sh $(FLAG) $(STG)
	cd aci-reporter/ && ./push_img.sh $(FLAG) $(STG)

frontend:
	#stg FLAG=testnet_stg STG=a
	#prod FLAG=prod
	cd aci-frontend/ && ./gen_img.sh $(FLAG) $(STG)
	#cd aci-frontend/ && ./push_img.sh $(FLAG) $(STG)

clean:
	#docker stop $(docker ps -aq) && docker rm -v $(docker ps -aq)
	docker images |grep none |awk -F " " "{print $$3}"#|xargs -r docker rmi -f
	#docker images | grep none |awk -F " " '{print $3}' | xargs -r docker rmi -f
