FROM node:12

ENV SESSION_SECRET = s3ss1on-s3cr3t \
    NODE_ENV=production \
    CLIENT_PORT = 4200 \
    PORT = 5000 \ 
    DATABASE_HOST = localhost \ 
    DATABASE_USERNAME = postgres \ 
    DATABASE_PASSWORD = Cqt20011101 \ 
    REDIS_PORT = 19229 \ 
    SERVER_URI = http://localhost \ 
    SERVER_ENDPOINT = /graphql \ 
    TEST_HOST = http://localhost:5050 \ 
    PROD_SERVER_HOST = https://ramen-server.herokuapp.com

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

ENV PORT=5000

EXPOSE 5000

RUN npm run build

CMD ["npm", "start"]