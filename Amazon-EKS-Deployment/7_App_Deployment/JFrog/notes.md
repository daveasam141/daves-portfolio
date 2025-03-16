### Installing Jfrog registry 

### Create namespace for artifactory 
kubectl create namespace artifactory 

### Create database deployment 
vim postgresql.yaml

apiVersion: apps/v1
kind: Deployment
metadata:
  name: postgresql
  namespace: artifactory
spec:
  replicas: 1
  selector:
    matchLabels:
      app: postgresql
  template:
    metadata:
      labels:
        app: postgresql
    spec:
      containers:
        - name: postgresql
          image: postgres:14
          ports:
            - containerPort: 5432
          env:
            - name: POSTGRES_DB
              value: artifactory
            - name: POSTGRES_USER
              value: artifactory
            - name: POSTGRES_PASSWORD
              value: (input_here)
          volumeMounts:
            - name: postgresql-data
              mountPath: /var/lib/postgresql/data
      volumes:
        - name: postgresql-data
          persistentVolumeClaim:
            claimName: postgresql
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: postgresql
  namespace: artifactory
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi



### Create the database and PVC
kubectl apply -f postgresql.yaml

### Create a service:
kubectl apply -f - <<EOF
apiVersion: v1
kind: Service
metadata:
  name: postgresql-service
  namespace: artifactory
spec:
  selector:
    app: postgresql
  ports:
    - protocol: TCP
      port: 5432
      targetPort: 5432


 ### Create a deployment file
 apiVersion: apps/v1
kind: Deployment
metadata:
  name: artifactory
  namespace: artifactory 
spec:
  replicas: 1
  selector:
    matchLabels:
      app: artifactory
  template:
    metadata:
      labels:
        app: artifactory
    spec:
      containers:
        - name: artifactory
          image: docker.bintray.io/jfrog/artifactory-oss:latest
          ports:
            - containerPort: 8081
          env:
            - name: DB_HOST
              value: postgresql-service.artifactory.svc.cluster.local
            - name: DB_PORT
              value: "5432"
            - name: DB_NAME
              value: artifactory
            - name: DB_USERNAME
              value: artifactory
            - name: DB_PASSWORD
              value: ###(input_here)
          volumeMounts:
            - name: artifactory-data
              mountPath: /var/opt/jfrog/artifactory
      volumes:
        - name: artifactory-data
          persistentVolumeClaim:
            claimName: jfrog

### Create Pvc
kubectl apply -f - <<EOF
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: jfrog
  namespace: artifactory
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi


### Apply deployment manifest 
kubectl apply -f jfrog.yaml

### Create JFrof Service
kubectl apply -f - <<EOF
apiVersion: v1
kind: Service
metadata:
  name: artifactory
  namespace: artifactory
spec:
  selector:
    app: artifactory
  ports:
    - name: http
      protocol: TCP
      port: 8082
      targetPort: 8082

### Create ingress
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: jfrog-ingress
  namespace: <my-ingress-namespace>
spec:
  ingressClassName: nginx
  rules:
    - host: jfrog.computingforgeeks.com
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: <jfrog-service-name>
                port:
                  number: 8082

### Apply ingresss
kubectl apply -f jfrog-ingress.yaml

### View ingress
kubectl get ing -n (namespace )
            

### To troubleshoot pods 
 kubectl describe pod artifactory-76f9c468cc-qcrtp -n artifactory (pod name the -n (namespace))

 ### To remove k8s object 
 kubectl delete -f (object name)