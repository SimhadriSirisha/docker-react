#below this line will considered as builder code
FROM node:16-alpine as builder 
USER node
RUN mkdir -p /home/node/app
WORKDIR '/home/node/app'
COPY --chown=node:node ./package.json ./
RUN npm install
COPY --chown=node:node ./ ./
RUN npm run build

#no need to specify the phase, 
#FROM keyword will be considered as start of new block
FROM nginx
#--from, used to tell that we need something from the previous phases
COPY --from=builder /home/node/app/build /usr/share/nginx/html
#to start we dont require to care abt specifying nginx start cmd it will 
# automatically done.