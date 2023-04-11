kubectl expose deploy nginx --type=LoadBalancer --port=80

apiVersion: v1
kind: Service
metadata:
  name: nginx
  annotations:
    metallb.universe.tf/loadBalancerIPs: 192.168.1.100
spec:
  ports
  - port: 80
    targetPort: 80
  selector:
    app: nginx
  type: LoadBalancer
