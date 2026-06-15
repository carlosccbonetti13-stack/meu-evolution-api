FROM atendai/evolution-api:latest

# Injeta as variáveis diretamente na construção do contêiner
ENV DATABASE_ENABLED="true"
ENV DATABASE_PROVIDER="postgresql"
ENV DATABASE_CONNECTION_URI="postgresql://evolution_user:KM8vEDOIZ4AYLOXtkuubv5YenKHW52J0@dpg-d8nemj3bc2fs73evmcm0-a/evolution_rmbk"
ENV DATABASE_CONNECTION_STRING="postgresql://evolution_user:KM8vEDOIZ4AYLOXtkuubv5YenKHW52J0@dpg-d8nemj3bc2fs73evmcm0-a/evolution_rmbk"

# Configurações de inicialização da porta
ENV PORT=8080
EXPOSE 8080

CMD ["node", "dist/src/main.js"]
