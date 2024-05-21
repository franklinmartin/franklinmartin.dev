FROM node:lts AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx:alpine AS runtime
COPY ./nginx/conf.d/app.conf /etc/nginx/conf.d/app.conf
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
#COPY ./nginx/. /etc/nginx/
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 8080