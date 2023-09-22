# Use official node image as the base image
FROM node:16 as build
# Set the working directory
WORKDIR /usr/local/app

# Add the source code to app
COPY ./ /usr/local/app/

# Install all the dependencies
RUN npm install
RUN npm install -g @angular/cli@13.0.1
RUN npm run build

# Use official nginx image as the base image
FROM nginx:latest

# Copy the build output to replace the default nginx contents.
COPY --from=build /usr/local/app/dist/angularapp /usr/share/nginx/html
