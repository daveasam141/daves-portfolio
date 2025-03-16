### Deploying falco sidekick with helm 
helm repo add falcosecurity https://falcosecurity.github.io/charts
helm repo update
helm install falco falcosecurity/falco --set falcosidekick.enabled=true --set falcosidekick.webui.enabled=true --namespace falco2 --create-namespace

### Verify that the falcosidekick pod is running 
k get pods -n falco2

### Port forward to reach the falcosidekick ui from web browser 
kubectl port-forward  falco-falcosidekick-ui-8556b688d8-jrrxw  2802:2802 -n falco2 (must include the ns to find the pod)

### UI login credentials 
username
password:

### To check l0ogs for falco 
kubectl logs -l app.kubernetes.io/name=falco -n falco2 -c falco   

### website url for bucket (this is for requesting an object that is already stored in the s3 bucket you replace object-name with the name of the object in the s3 bucket that you're trying to reach )
http://bucket-name.s3-website.Region.amazonaws.com/object-name

### To get an api url i created amn access point  for my 23 bucketon the aws console, then using an endpoint for s3 i created an endpoint url for the bucket 
falco-point.s3-accesspoint.us-east-2.amazonaws.com 
syntax:(access-point).s3-accesspoint.(AWS Region code).amazonaws.com
test-1-tpe9n9sc1f5ac5zuorkq3yayzun5ause2a-s3alias

### To set s3 bucket for falco 
noglob helm upgrade falco \
    --version 4.0.0 \
    --namespace falco2 \
    --set tty=true \
    --set falcosidekick.config.aws.accesskeyid= \
    --set falcosidekick.config.aws.secretaccesskey= \
    --set falcosidekick.config.aws.checkidentity=false \
    --set falcosidekick.config.aws.s3.bucket=falco \
    --set falcosidekick.config.aws.region=us-east-2 \
    --set falcosidekick.config.extraEnv[0].name=AWS_S3_ENDPOINT,falcosidekick.config.extraEnv[0].value=falco-point.s3-accesspoint.us-east-2.amazonaws.com  \
  falcosecurity/falco

noglob helm upgrade falco \
    --version 4.0.0 \
    --create-namespace \
    --namespace falco2 \
    --set tty=true \
    --set falcosidekick.enabled=true \
    --set falcosidekick.image.tag=latest \
    --set falcosidekick.webui.enabled=true \
    --set falcosidekick.webui.user=admin:admin \
    --set falcosidekick.webui.service.type=ClusterIP \
    --set falcosidekick.config.aws.accesskeyid= \
    --set falcosidekick.config.aws.secretaccesskey=\
    --set falcosidekick.config.aws.checkidentity=false \
    --set falcosidekick.config.aws.s3.bucket=falco \
    --set falcosidekick.config.aws.region=us-east-2 \
    --set falcosidekick.config.extraEnv[0].name=AWS_S3_ENDPOINT,falcosidekick.config.extraEnv[0].value=falco-point.s3-accesspoint.us-east-2.amazonaws.com \
  falcosecurity/falco

### To check logs 
kubectl logs -l app.kubernetes.io/part-of=falcosidekick --all-containers -n falco2 -f --max-log-requests 8


### Redis
Remote Dictionary Server:When an application relies on external data sources, the latency and throughput of those sources can create a performance bottleneck, especially as traffic increases or the application scales. One way to improve performance in these cases is to store and manipulate data in-memory, physically closer to the application. Redis is built to this task: It stores all data in-memory—delivering the fastest possible performance when reading or writing data—and offers built-in replication capabilities that let you place data physically closer to the user for the lowest latency.

### To troubleshoot 
kubectl logs <pod_name> 
kubectl logs falco-falcosidekick-ui-6568c775-vf6wq -n falco2

kubectl port-forward falco-falcosidekick-ui-6568c775-vf6wq  2802:2802






### References 
https://docs.aws.amazon.com/general/latest/gr/s3.html
https://github.com/falcosecurity/charts/blob/master/charts/falcosidekick/README.md
https://help.ovhcloud.com/csm/en-public-cloud-kubernetes-runtime-security-falco?id=kb_article_view&sysparm_article=KB0062463
 6379



