docker build -t jayesh0099/multi-client:latest -t jayesh0099/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jayesh0099/multi-server:latest -t jayesh0099/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jayesh0099/multi-worker:latest -t jayesh0099/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push jayesh0099/multi-client:latest
docker push jayesh0099/multi-server:latest
docker push jayesh0099/multi-worker:latest
docker push jayesh0099/multi-client:$SHA
docker push jayesh0099/multi-server:$SHA
docker push jayesh0099/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jayesh0099/multi-server:$SHA
kubectl set image deployments/client-deployment client=jayesh0099/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jayesh0099/multi-worker:$SHA