# load NodeJs 12.18.3 docker image
FROM node:12.18.3

# set work directory
WORKDIR /app

# install node packages
COPY package*.json ./
RUN npm install

# build app
COPY .env .
COPY . .
RUN npm run generate

# expose port
EXPOSE 2000

# on container run, run command
CMD [ "npm", "run", "start" ]
