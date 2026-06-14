FROM atendai/evolution-api:latest

# Define a porta padrão do contêiner
ENV PORT=8080
EXPOSE 8080

# Comando oficial de inicialização da Evolution API
CMD ["node", "dist/src/main.js"]
