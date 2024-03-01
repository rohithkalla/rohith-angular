# Stage 1: Build Angular application
FROM node:18.19.0 as build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json to install dependencies
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the Angular application 
RUN npm run build

# Stage 2: Create production-ready image with Nginx
FROM nginx:alpine

# Copy the built Angular application to Nginx
COPY --from=build /app/dist//my-angularapp/browser /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]