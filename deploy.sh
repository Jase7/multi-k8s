docker build -t grumpywolf7/multi-client:latest -t grumpywolf/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t grumpywolf7/multi-server:latest -t grumpywolf/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t grumpywolf7/multi-worker:latest -t grumpywolf/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push grumpywolf7/multi-client:latest
docker push grumpywolf7/multi-server:latest
docker push grumpywolf7/multi-worker:latest

docker push grumpywolf7/multi-client:$SHA
docker push grumpywolf7/multi-server:$SHA
docker push grumpywolf7/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=grumpywolf7/multi-server:$SHA
kubectl set image deployments/client-deployment client=grumpywolf7/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=grumpywolf7/multi-worker:$SHA