FROM node:15-slim as builder

WORKDIR /app

COPY . .

RUN npm install
RUN npm ci --only=production
RUN npm run build

FROM nginx:latest
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=builder /app/build .
EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]