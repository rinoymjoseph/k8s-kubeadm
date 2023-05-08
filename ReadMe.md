echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers
sudo visudo -c

sudo apt update
sudo apt install software-properties-common unzip sshpass python3-pip -y
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y
pip3 install kubernetes

kubectl patch svc prometheus-kube-prometheus-prometheus -p '{"spec": {"type": "NodePort"}}'

kubectl patch svc prometheus-kube-prometheus-prometheus --type='json' -p \
'[{"op":"replace","path":"/spec/type","value":"NodePort"},{"op":"replace","path":"/spec/ports/0/nodePort","value":30000}]' -n monitoring

kubectl patch svc prometheus --type='json' -p \
'[{"op":"replace","path":"/spec/type","value":"NodePort"},{"op":"replace","path":"/spec/ports/0/nodePort","value":30001}]'

kubectl patch svc my-otel-demo-frontendproxy --type='json' -p \
'[{"op":"replace","path":"/spec/type","value":"NodePort"},{"op":"replace","path":"/spec/ports/0/nodePort","value":30000}]'

kubectl patch svc my-collector-collector --type='json' -p \
'[{"op":"replace","path":"/spec/type","value":"NodePort"},{"op":"replace","path":"/spec/ports/0/nodePort","value":30080}]'

kubectl patch svc jaeger-demo-query --type='json' -p '[{"op":"replace","path":"/spec/type","value":"NodePort"},{"op":"replace","path":"/spec/ports/0/nodePort","value":30001}]' -n observability

kubectl patch svc edgenius-otel-collector --type='json' -p '[{"op":"replace","path":"/spec/type","value":"NodePort"},{"op":"replace","path":"/spec/ports/0/nodePort","value":30010}]' -n edgenius

kubectl patch svc otel-edgenius-metrics --type='json' -p '[{"op":"replace","path":"/spec/type","value":"NodePort"},{"op":"replace","path":"/spec/ports/0/nodePort","value":30011}]' -n edgenius

kubectl patch svc otel-edgenius-collector-monitoring --type='json' -p '[{"op":"replace","path":"/spec/type","value":"NodePort"},{"op":"replace","path":"/spec/ports/0/nodePort","value":30012}]' -n edgenius

oc patch svc otel-edgenius-metrics --type='json' -p '[{"op":"replace","path":"/spec/type","value":"NodePort"},{"op":"replace","path":"/spec/ports/0/nodePort","value":30011}]' -n edgenius

oc patch svc otel-edgenius-collector-monitoring --type='json' -p '[{"op":"replace","path":"/spec/type","value":"NodePort"},{"op":"replace","path":"/spec/ports/0/nodePort","value":30012}]' -n edgenius


http://192.168.0.161:30012/metrics
http://192.168.0.161:30011/metrics


USER=ability; PASSWORD=welcome123#; echo "${USER}:$(openssl passwd -stdin -apr1 <<< ${PASSWORD})" >> auth

kubectl create secret docker-registry griffinsreg --namespace edgenius \
--docker-server griffins.azurecr.io \
--docker-username griffins \
--docker-password I24ZwLkmhpaUR1MLP=gbPZLMSTPpjWzW \
--docker-email rinoymjoseph@gmail.com