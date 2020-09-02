FROM node:12-alpine as builder

COPY src/frontend-v1/package.json src/frontend-v1/package-lock.json ./
RUN npm i && mkdir /ng-app && mv ./node_modules ./ng-app
WORKDIR /ng-app
COPY src/frontend-v1/. .
RUN $(npm bin)/ng build --prod --output-path=dist

FROM nginx:1.19.2-alpine
COPY src/nginx/default.conf /etc/nginx/conf.d/
RUN rm -rf /usr/share/nginx/html/*
COPY --from=builder /ng-app/dist /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]