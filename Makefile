echo 'FLAG:'$(FLAG)
echo 'STG:'$(STG)

.IGNORE: local_update build push clean

local_update:
	cd aci-backend/ && yarn add ../aci-commons
	cd aci-demux-backend/ && yarn add ../aci-commons

build:
	cd aci-backend/ && ./gen_img.sh $(FLAG)
	#cd aci-demux-backend/ && ./gen_img.sh $(FLAG)
	cd aci-frontend/ && ./gen_img.sh $(FLAG)
	cd aci-blockchain-updater/ && ./gen_img.sh $(FLAG)
	#cd aci-reporter/ && ./gen_img.sh $(FLAG)

push:
	cd aci-backend/ && ./push_img.sh $(FLAG)
	#cd aci-demux-backend/ && ./push_img.sh $(FLAG)
	cd aci-frontend/ && ./push_img.sh $(FLAG)
	cd aci-blockchain-updater/ && ./push_img.sh $(FLAG)
	#cd aci-reporter/ && ./push_img.sh $(FLAG)

all: build push

backend:
	cd aci-backend/ && ./gen_img.sh $(FLAG)
	cd aci-backend/ && ./push_img.sh $(FLAG)

demux:
	cd aci-demux-backend/ && ./gen_img.sh $(FLAG)
	cd aci-demux-backend/ && ./push_img.sh $(FLAG)

updater:
	cd aci-blockchain-updater/ && ./gen_img.sh $(FLAG)
	cd aci-blockchain-updater/ && ./push_img.sh $(FLAG)

reporter:
	cd aci-reporter/ && ./gen_img.sh $(FLAG)
	cd aci-reporter/ && ./push_img.sh $(FLAG)

frontend:
	cd aci-frontend/ && ./gen_img.sh $(FLAG) $(STG)
	cd aci-frontend/ && ./push_img.sh $(FLAG) $(STG)

clean:
	#docker stop $(docker ps -aq) && docker rm -v $(docker ps -aq)
	docker images |grep none |awk -F " " "{print $$3}"#|xargs -r docker rmi -f
	#docker images | grep none |awk -F " " '{print $3}' | xargs -r docker rmi -f
