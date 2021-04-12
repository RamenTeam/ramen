FROM node:12

ENV SESSION_SECRET = s3ss1on-s3cr3t 

ENV NODE_ENV=staging 

ENV CLIENT_PORT = 4200 

ENV PORT = 5000  

ENV DATABASE_HOST = localhost  

ENV DATABASE_USERNAME = postgres  

ENV DATABASE_PASSWORD = Cqt20011101  

ENV REDIS_PORT = 19229  

ENV SERVER_URI = http://localhost  

ENV SERVER_ENDPOINT = /graphql  

ENV TEST_HOST = http://localhost:5050  

ENV PROD_SERVER_HOST = https://ramen-server.herokuapp.com

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY .env .

COPY . .

ENV PORT=5000

EXPOSE 5000

RUN npm run build

COPY wait-for-it.sh .

CMD ["npm", "start"]