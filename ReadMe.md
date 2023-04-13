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

kubectl patch svc my-otel-demo-frontend --type='json' -p \
'[{"op":"replace","path":"/spec/type","value":"NodePort"},{"op":"replace","path":"/spec/ports/0/nodePort","value":30001}]'

kubectl patch svc my-otel-demo-grafana --type='json' -p \
'[{"op":"replace","path":"/spec/type","value":"NodePort"},{"op":"replace","path":"/spec/ports/0/nodePort","value":30002}]'

kubectl patch svc my-otel-demo-loadgenerator --type='json' -p \
'[{"op":"replace","path":"/spec/type","value":"NodePort"},{"op":"replace","path":"/spec/ports/0/nodePort","value":30003}]'

kubectl patch svc my-otel-demo-jaeger-query --type='json' -p \
'[{"op":"replace","path":"/spec/type","value":"NodePort"},{"op":"replace","path":"/spec/ports/0/nodePort","value":30004}]'

USER=ability; PASSWORD=welcome123#; echo "${USER}:$(openssl passwd -stdin -apr1 <<< ${PASSWORD})" >> auth