FROM node:alpine
WORKDIR /app
COPY ./CoreEvidence.json .
COPY ./main.js .
COPY ./package.json .
COPY ./package-lock.json .
RUN npm install
CMD "node /app/main.js"
