FROM node:12

ENV SESSION_SECRET = s3ss1on-s3cr3t 

ENV NODE_ENV=staging 

ENV PORT = 5000  

ENV POSTGRES_HOST = localhost  

ENV POSTGRES_USER = postgres  

ENV POSTGRES_PASSWORD = Cqt20011101  

ENV MONGODB_URI = mongodb://localhost:27107/session

ENV SERVER_URI = http://localhost  

ENV SERVER_ENDPOINT = /graphql  

ENV PORT=5000

WORKDIR /app

COPY package-lock.json .

COPY package*.json .

RUN npm install

COPY .env .

COPY . .

EXPOSE 5000

RUN npm run build

COPY wait-for-it.sh .

CMD ["npm", "start"]