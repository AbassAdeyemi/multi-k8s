docker build -t abassadey/multi-client:latest -t abassadey/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t abassadey/multi-server:latest -t abassadey/multi-server:$SHA -f ./client/Dockerfile ./server
docker build -t abassadey/multi-worker:latest -t abassadey/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push abassadey/multi-client:latest
docker push abassadey/multi-server:latest
docker push abassadey/multi-worker:latest
docker push abassadey/multi-client:$SHA
docker push abassadey/multi-server:$SHA
docker push abassadey/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=abassadey/multi-server:$SHA
kubectl set image deployments/client-deployment client=abassadey/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=abassadey/multi-worker:$SHA