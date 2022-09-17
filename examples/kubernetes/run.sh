kubectl create namespace pg-stolon
kubectl apply -f role-binding.yaml
kubectl apply -f role.yaml
kubectl run -n pg-stolon -i -t stolonctl --image=sorintlab/stolon:master-pg14 --restart=Never --rm -- /usr/local/bin/stolonctl --cluster-name=kube-stolon --store-backend=kubernetes --kube-resource-kind=configmap init --kube-namespace=pg-stolon
kubectl create -f stolon-sentinel.yaml -n pg-stolon
kubectl create -f secret.yaml -n pg-stolon
kubectl create -f stolon-keeper.yaml -n pg-stolon
sleep 60
kubectl create -f stolon-proxy.yaml -n pg-stolon
kubectl create -f stolon-proxy-service.yaml -n pg-stolon
sleep 30
kubectl get all -n pg-stolon