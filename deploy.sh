docker build -t kreekeris/multi-client:latest -t kreekeris/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kreekeris/multi-server:latest -t kreekeris/multi-server:$SHA-f ./server/Dockerfile ./server
docker build -t kreekeris/multi-worker:latest -t kreekeris/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push kreekeris/multi-client:latest
docker push kreekeris/multi-client:$SHA
docker push kreekeris/multi-server:latest
docker push kreekeris/multi-server:$SHA
docker push kreekeris/multi-worker:latest
docker push kreekeris/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=kreekeris/multi-client:$SHA
kubectl set image deployments/server-deployment server=kreekeris/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=kreekeris/multi-worker:$SHA

