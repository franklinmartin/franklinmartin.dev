FROM node:lts AS build
WORKDIR /app
COPY package*.json ./
RUN npm install -g npm@10.7.0
RUN npm install astro 
COPY . .
RUN npm run astro build

FROM nginx:alpine AS runtime
COPY ./nginx/conf.d/app.conf /etc/
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 4321