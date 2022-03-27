# Pull from docker hub
docker pull gkweston/csce438:base;

# Retag the image so it works with the provided scripts
docker tag gkweston/csce438:base csce438:base;

# Remove the image tagged with my Docker Hub repo
docker image rm gkweston/csce438:base;
