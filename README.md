Bring up containers:
    docker-compose up -d

Wait a few seconds for containers to start, then:
    ./runclient.sh

Then in container:
    ./provision.sh nonprod
    ./provision.sh prod

When done, leave client container:
    exit

And terminate containers:
    docker-compose down
