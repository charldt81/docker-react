# Start with a base image and specify which stage to use the image as, eg... 'builder'
FROM node:alpine as builder

# Specify a working directory which you want to save your application to
WORKDIR '/app'

# Copy the 'package.json' file to the '/app' directory
COPY package.json .

# Run the 'npm install' command to get the dependencies
RUN npm install

# Copy the rest of the files from the project directory, into the specified work directory -> '/app'
COPY . .

# Use the "npm run start" command to start the application
RUN npm run build

########################################################

# Create another image after the one above has completed
FROM nginx

# Copy the required file, created by the 'builder' stage from the '/app/build' location, into '/usr/share/nginx/html'
COPY --from=builder /app/build /usr/share/nginx/html
