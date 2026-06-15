FROM atendai/evolution-api:latest

ENV CONFIG_SESSION_PHONE_VERSION="2.3000.1028148389"
ENV CACHE_PROVIDER="local"
ENV CACHE_REDIS_ENABLED="false"
ENV REDIS_ENABLED="false"
ENV AUTHENTICATION_TYPE="apikey"
ENV AUTHENTICATION_API_KEY="NARUTO28"
ENV GLOBAL_API_KEY="NARUTO28"
ENV DATABASE_ENABLED="true"
ENV DATABASE_PROVIDER="postgresql"
ENV DATABASE_CONNECTION_URI="postgresql://evolution_user:KM8vEDOIZ4AYLOXtkuubv5YenKHW52J0@dpg-d8nemj3bc2fs73evmcm0-a.ohio-postgres.render.com/evolution_rmbk"
ENV DATABASE_CONNECTION_STRING="postgresql://evolution_user:KM8vEDOIZ4AYLOXtkuubv5YenKHW52J0@dpg-d8nemj3bc2fs73evmcm0-a.ohio-postgres.render.com/evolution_rmbk"
ENV PORT=8080
ENV HOSTNAME="0.0.0.0"

EXPOSE 8080
ENV HOST="0.0.0.0"
ENV SERVER_HOST="0.0.0.0"

CMD ["node", "dist/main.js"]
