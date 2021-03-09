# Sample usage with a mounted data directory and fast sync:
# > docker build --tag idena .
# > docker run --network host --volume ~/.idena/datadir:/idena/datadir idena --fast

FROM ubuntu AS builder

WORKDIR /idena

RUN apt-get update && \
    apt-get  install -y jq wget
RUN wget https://api.github.com/repos/idena-network/idena-go/releases/latest
RUN wget -O "./idena" $(jq --raw-output '.assets | map(select(.name | startswith("idena-node-linux"))) | .[0].browser_download_url' "./latest")

FROM ubuntu

WORKDIR /idena

COPY --from=builder /idena/ .
COPY docker-entrypoint.sh /usr/bin/docker-entrypoint.sh
RUN chmod +x "./idena"
RUN mv ./idena /usr/bin

EXPOSE 9009

ENTRYPOINT ["bash","/usr/bin/docker-entrypoint.sh"]
