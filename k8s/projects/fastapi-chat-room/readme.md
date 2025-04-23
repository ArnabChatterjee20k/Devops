### Moto
A basic fastapi websocket based chat app

* kind load docker-image <image name>

* docker exec -it kind-control-plane crictl images | grep <image name>

* docker exec -it kind-control-plane crictl rmi chat-room-frontend

-> services, deployment, daemon set(monitor), ingress controller with nginx