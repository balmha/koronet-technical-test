# Description: Dockerfile for the nodejs app. The nodejs app is a simple app that listens on port 3000 and returns a simple message. The webserver files are located at ./webserver folder

FROM node:10
WORKDIR /usr/src/app
COPY webserver/ ./
RUN npm install
EXPOSE 3000
CMD ["node", "app.js"]