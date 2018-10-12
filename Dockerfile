# Downloading minimal nodejs image
FROM node:alpine

ENV http_proxy=${http_proxy} \
    https_proxy=${https_proxy} \
    no_proxy="${no_proxy}"

# Proxy set up for NPM
RUN if [ ! -z "${http_proxy}" ]; then \
        echo "Using proxy => ${http_proxy}"; \
        npm config set https-proxy="${http_proxy}" --global; \
        npm config set http-proxy="${http_proxy}" --global; \
        npm config set proxy="${http_proxy}" --global; \
        npm config set strict-ssl=false --global; \
    else \
        echo 'No proxy set'; \
    fi;

# Installing hubot software
RUN npm install -g yo generator-hubot

# Create hubot user
RUN adduser -h /hubot -s /bin/sh -S hubot -u 1100

# Log in as hubot user and change directory
USER hubot
WORKDIR /hubot

# Generating Hubot
RUN yo hubot --owner="SaurioREX" --name="Riptor" --description="HuBot for UseIT" --adapter="flowdock" --defaults

RUN npm install

# Adding personal scripts
COPY --chown=1100 ./scripts/ /hubot/

# Starting bot
CMD bin/hubot -a flowdock
