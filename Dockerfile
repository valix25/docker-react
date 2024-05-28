# Production setup. 2 stages. Build + Run stages.

# Stage 1: Build
FROM node:21-alpine AS builder

WORKDIR /app

# Install some dependencies
COPY ./package.json ./
RUN npm install
COPY ./ ./

RUN npm run build

# /app/build <-- all the build necessary files for production created in the container

# Stage 2: Run

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html

# docker run -p 8080:80 168e60c23f7
# 80 default nginx port
