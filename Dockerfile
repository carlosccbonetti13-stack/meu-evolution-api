FROM atendai/evolution-api:latest

# Expõe a porta padrão da Evolution API
EXPOSE 8080

# Comando para iniciar a aplicação
CMD ["node", "dist/src/main.js"]

