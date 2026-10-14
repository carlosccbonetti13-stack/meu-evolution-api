# Evolution API 2.3.7 + correção de pareamento do WhatsApp (Baileys rc14 + patch companion_reg_refresh)
#
# Este Dockerfile baixa o código oficial da tag 2.3.7 na hora do build, troca o Baileys
# (rc.9 -> rc14) e aplica o patch em patches/baileys+7.0.0-rc14.patch.
# Origem do patch: https://github.com/evolution-foundation/evolution-api/pull/2727
# Quando a correção oficial sair, volte para a imagem oficial evoapicloud/evolution-api.

FROM node:24-alpine AS builder

RUN apk update && \
    apk add --no-cache git ffmpeg wget curl bash openssl

WORKDIR /evolution

# Código oficial da versão 2.3.7
RUN git clone --depth 1 --branch 2.3.7 https://github.com/EvolutionAPI/evolution-api.git .

# Troca o Baileys e aplica o patch (falha o build se o patch não encaixar)
COPY ./patches ./patches
RUN npm install --silent --save-exact baileys@7.0.0-rc14 patch-package@8
RUN npx patch-package --error-on-fail

RUN cp ./.env.example ./.env
RUN chmod +x ./Docker/scripts/* && dos2unix ./Docker/scripts/*

RUN ./Docker/scripts/generate_database.sh

RUN NODE_OPTIONS="--max-old-space-size=2048" npm run build

FROM node:24-alpine AS final

RUN apk update && \
    apk add tzdata ffmpeg bash openssl

ENV TZ=America/Sao_Paulo
ENV DOCKER_ENV=true

WORKDIR /evolution

COPY --from=builder /evolution/package.json ./package.json
COPY --from=builder /evolution/package-lock.json ./package-lock.json
COPY --from=builder /evolution/node_modules ./node_modules
COPY --from=builder /evolution/dist ./dist
COPY --from=builder /evolution/prisma ./prisma
COPY --from=builder /evolution/manager ./manager
COPY --from=builder /evolution/public ./public
COPY --from=builder /evolution/.env ./.env
COPY --from=builder /evolution/Docker ./Docker
COPY --from=builder /evolution/runWithProvider.js ./runWithProvider.js
COPY --from=builder /evolution/tsup.config.ts ./tsup.config.ts

EXPOSE 8080

ENTRYPOINT ["/bin/bash", "-c", ". ./Docker/scripts/deploy_database.sh && npm run start:prod" ]
