FROM debian:10

ENV VERSION=v1.1.13

WORKDIR /opt

RUN apt update && apt install -y wget unzip

RUN wget -qO /bin/geth https://github.com/binance-chain/bsc/releases/download/${VERSION}/geth_linux && \
    chmod +x /bin/geth

RUN wget -qO config.zip https://github.com/binance-chain/bsc/releases/download/${VERSION}/mainnet.zip && \
    unzip config.zip && rm -f config.zip

RUN apt autoremove -y && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/bin/geth"]
