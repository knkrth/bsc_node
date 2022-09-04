FROM debian:10

ENV VERSION=v1.1.13

WORKDIR /opt

RUN apt update && apt install -y wget unzip

RUN wget -qO /bin/geth https://github.com/binance-chain/bsc/releases/download/${VERSION}/geth_linux && \
    chmod +x /bin/geth

RUN wget -qO config.zip https://github.com/binance-chain/bsc/releases/download/${VERSION}/mainnet.zip && \
    unzip config.zip && \
    sed -i 's/^HTTPHost.*/HTTPHost = "0.0.0.0"/' config.toml && \
    sed -i '/^WSPort.*/a WSHost = "0.0.0.0"' config.toml && \
    sed -i 's/^HTTPVirtualHosts.*/HTTPVirtualHosts = ["*"]/' config.toml && \
    sed -i '/Node\.LogConfig/,/^$/d' config.toml && \
    rm -f config.zip

RUN apt autoremove -y && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/bin/geth"]
