FROM node:lts AS runtime
WORKDIR /app

COPY . .
RUN npm install -g npm@10.5.1
RUN npm install @astrojs/node --force 
RUN npm run build

ENV HOST=0.0.0.0
ENV PORT=4321
EXPOSE 4321
CMD node ./dist/server/entry.mjs