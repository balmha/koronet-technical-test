# I used a multi-stage approach, honestly it just saves 6MB, alpine is the main size reduction in NodeJS builds.

# Stage 1: Build
FROM node:18-alpine AS build
WORKDIR /usr/src/app
COPY webserver/package*.json ./
RUN npm install
COPY webserver/ ./

# Stage 2: Production
FROM node:18-alpine
WORKDIR /usr/src/app
COPY --from=build /usr/src/app ./
EXPOSE 3000
CMD ["node", "app.js"]
