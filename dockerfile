FROM node:lts AS build
WORKDIR /app
COPY package*.json ./
RUN npm install -g npm@10.7.0
COPY . .
RUN npm run build

FROM nginx:alpine AS runtime
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 8080