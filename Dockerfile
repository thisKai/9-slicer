FROM node:7
RUN npm install -g elm
RUN mkdir /code
VOLUME /code
WORKDIR /code
EXPOSE 8000
CMD ["elm", "make", "./app/Main.elm", "--output", "app.js"]
