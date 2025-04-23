# !/bin/sh
docker rmi chat-room-frontend -f
docker build -t chat-room-frontend .
docker run -p 9002:9000 -d chat-room-frontend