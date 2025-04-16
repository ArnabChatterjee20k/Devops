# !/bin/bash
kubectl create deployment web-app --image=nginx --replicas=3 --dry-run=client -o yaml > deployment.yml

kubectl apply -f deployment.yml
# adding rolling update strategy
kubectl patch deployment web-app -p '{
  "spec": {
    "strategy": {
      "type": "RollingUpdate",
      "rollingUpdate": {
        "maxSurge": 1,
        "maxUnavailable": 1
      }
    }
  }
}'

kubectl get deploy/web-app

# changing image
kubectl set image deployments/web-app nginx=nginx:1.23.4
kubectl scale deploy web-app --replicas=10

kubectl get deploy/web-app

echo -e "\n Rollout History:"
kubectl rollout history deployment web-app

# rolling back to prev nginx
kubectl rollout undo deployment web-app --to-revision=1

kubectl rollout status deployment web-app
kubectl get deploy/web-app -o wide