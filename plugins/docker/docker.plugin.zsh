#!/bin/zsh
function docker-tags {
	echo $1 | grep '/' && image=$1 || image=library/$1
	curl -s -S "https://registry.hub.docker.com/v2/repositories/${image}/tags/" | jq '."results"[]["name"]' |sort
}
