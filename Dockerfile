FROM node:20-alpine AS builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
# this /usr/share/nginx/html is the default location from where nginx serves the content.
COPY --from=builder /app/build /usr/share/nginx/html

# Here we are dividing the whole process into two phases. Build and Run phase
# In a production environment we dont need the node modules folder, and rest of the src code
# So we make one new container for nginx which only takes the build folder from BUILd stage
