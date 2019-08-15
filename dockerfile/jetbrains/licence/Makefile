docker_name = jetbrains

build :
	docker build -t $(docker_name) .
run :
	docker run -it --rm --env USER_NAME=ding -p 1228:1228 --name jetbrains $(docker_name)

rm :
	docker rmi $(docker_name)

clean :
	rm JetBrainsLicenseServer*
