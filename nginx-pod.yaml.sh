apiVersion: v1
kind: Pod
metadata:
  name: nginx
  labels: 
    web-server : nginx
spec:
  containers:
  - name: nginx
    image: nginx:1.14.2
    ports:
    - containerPort: 80