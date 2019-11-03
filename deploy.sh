docker build -t aymanacc/multi-client:latest -t aymanacc/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t aymanacc/multi-server:latest -t aymanacc/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t aymanacc/multi-worker:latest -t aymanacc/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push aymanacc/multi-client:latest
docker push aymanacc/multi-server:latest
docker push aymanacc/multi-worker:latest

docker push aymanacc/multi-client:$SHA
docker push aymanacc/multi-server:$SHA
docker push aymanacc/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=aymanacc/multi-server:$SHA
kubectl set image deployments/client-deployment client=aymanacc/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=aymanacc/multi-worker:$SHA