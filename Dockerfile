# Estágio de construção
FROM node:14-alpine AS build

# Definir o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copiar arquivos de configuração do projeto
COPY package.json package-lock.json ./

# Instalar dependências
RUN npm install

# Copiar o restante dos arquivos do projeto
COPY . .

# Construir o aplicativo React
RUN npm run build



# Estágio de produção
FROM nginx:alpine

# Copiar os arquivos de construção do estágio de construção
COPY --from=build /app/build /usr/share/nginx/html

# Configurar o Nginx para rodar a aplicação React
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
