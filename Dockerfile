FROM node:14-slim

# @see Derived from https://github.com/GoogleChrome/rendertron/issues/775

# Update aptitude with new repo
RUN apt-get update

# Install software 
RUN apt-get install -y git

# Install Chromium dependencies (https://github.com/puppeteer/puppeteer/issues/1598#issuecomment-473436669)
RUN apt-get install -y libatk1.0-0 libatk-bridge2.0-0 libgtk-3-0 libgbm1 libnss3 libasound2
    
# Fetch repository
RUN git clone https://github.com/GoogleChrome/rendertron.git

# Get inside the cloned folder
WORKDIR ./rendertron

# Copy config.json from local filesystem to image working-dir
COPY config.json .

# Build application
RUN npm install
RUN npm run build

# Launch application
CMD [ "npm", "run", "start" ]

# Expose port
EXPOSE 3000/tcp