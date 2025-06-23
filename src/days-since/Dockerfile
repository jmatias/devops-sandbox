FROM 386757133934.dkr.ecr.us-east-1.amazonaws.com/library/node:20-alpine AS builder
WORKDIR /app

COPY package*.json ./
RUN npm install

COPY src ./src
COPY index.html ./
COPY vite.config.ts ./
RUN npm run build

FROM 386757133934.dkr.ecr.us-east-1.amazonaws.com/library/nginx:alpine
#COPY .htpasswd /etc/nginx/.htpasswd
COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf


EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
