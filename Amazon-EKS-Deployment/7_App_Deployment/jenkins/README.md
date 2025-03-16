helm repo add jenkins https://charts.jenkins.io
helm repo update
helm pull jenkins/jenkins --untar
helm install jenkins jenkins/jenkins --namespace jenkins --create-namespace -f values.yaml

kubectl get svc -n jenkins
kubectl get ing -n jenkins
kubectl get pod -n jenkins -w

    annotations: 
       kubernetes.io/ingress.class: nginx
       kubernetes.io/tls-acme: "true"
       ingressClassName: nginx
    hostName: jenkins/2waveyyy.com
    path: 

