FROM alpine:latest

WORKDIR /app

COPY app.sh .

RUN chmod +x app.sh && apk add --no-cache busybox-extras

EXPOSE 80

CMD ["./app.sh"]