docker build -t aymanacc/multi-client:latest -t aymanacc/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t aymanacc/multi-server -f ./server/Dockerfile ./server
docker build -t aymanacc/multi-worker -f ./worker/Dockerfile ./worker
docker push aymanacc/multi-client
docker push aymanacc/multi-client:$SHA
docker push aymanacc/multi-server
docker push aymanacc/multi-worker
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=aymanacc/multi-client:$SHA
kubectl rollout restart deployment/server-deployment
kubectl rollout restart deployment/worker-deployment