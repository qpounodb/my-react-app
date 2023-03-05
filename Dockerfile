# BUILD

FROM node:lts AS build
WORKDIR /app

COPY package.json yarn.lock ./
RUN yarn install

COPY tsconfig* vite.config.ts ./
COPY index.html ./index.html
COPY public ./public
COPY src ./src
RUN yarn build

# SERVE

FROM nginx:alpine

COPY ./nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80
