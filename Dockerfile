FROM alpine:latest

WORKDIR /app

COPY app.sh .

RUN chmod +x app.sh && apk add --no-cache busybox-extras

#CMD ["./app.sh"]
CMD ["sh", "-c", "echo 'Hello from FULL CI/CD Pipeline 🚀' && sleep infinity"]

