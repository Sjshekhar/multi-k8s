docker build -t sjshekhar/multi-client:latest -t sjshekhar/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sjshekhar/multi-server:latest -t sjshekhar/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sjshekhar/multi-worker:latest -t sjshekhar/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push sjshekhar/multi-client:latest
docker push sjshekhar/multi-server:latest
docker push sjshekhar/multi-worker:latest
docker push sjshekhar/multi-client:$SHA
docker push sjshekhar/multi-server:$SHA
docker push sjshekhar/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sjshekhar/multi-server:$SHA
kubectl set image deployments/client-deployment client=sjshekhar/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sjshekhar/multi-worker:$SHA
