# build stage to package app into /app/build
FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# run stage where we will take the result of the above stage and copy over the build (not any source code_)
# directory into the default static web serving location on the nginx server 
# - resulting image will be base nginx with the /app/build contents
FROM nginx 
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html