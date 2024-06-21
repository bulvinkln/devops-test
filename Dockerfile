FROM node:14.15.0-stretch
WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn install
COPY public ./public
COPY src/ ./src
RUN yarn build
FROM nginx:alpine
COPY --from=0 /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]