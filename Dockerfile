FROM elixir:1.11

WORKDIR /usr/src

# RUN echo 'http://dl-cdn.alpinelinux.org/alpine/edge/main' > /etc/apk/repositories && \
#     echo 'http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories && \
#     cat /etc/apk/repositories && \
#     apk upgrade --update-cache --available && \
#     apk add --update bash git watchexec && mix local.hex --force && mix local.rebar --force

COPY mix.* ./

ARG MIX_ENV=dev
ENV MIX_ENV=${MIX_ENV}

RUN mix local.hex --force && mix local.rebar --force
RUN mix do deps.get, compile

COPY . .

RUN mix compile

CMD ["/bin/bash", "-c", "mix ecto.setup && mix phx.server"]