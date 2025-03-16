```sh 
### Important 
Elastic Search: This is the database which stores all the logs
Kibana : Kibana is the visualization platform and we can use Kibana to query Elastic Search
Logstash: Logstash is data ingestion tool. It ingests data(logs) from various sources and processes them before sending to Elastic Search
Filebeat: Filebeat is very important component and works as the log exporter. It exports and forwards the log to Logstash.

### Installing Logging tools 

### Using wget to pull only the values.yaml file instead of untarring the whole helm chart (-0 argument renames the file you're downloading)
wget https://raw.githubusercontent.com/elastic/helm-charts/main/elasticsearch/values.yaml -O elastic-values.yaml
wget https://raw.githubusercontent.com/elastic/helm-charts/main/kibana/values.yaml -O kibana-values.yaml
wget https://raw.githubusercontent.com/elastic/helm-charts/main/logstash/values.yaml -O logstash-values.yaml
wget https://raw.githubusercontent.com/elastic/helm-charts/main/filebeat/values.yaml -O filebeat-values.yaml
wget https://raw.githubusercontent.com/elastic/helm-charts/main/metricbeat/values.yaml -O metricbeat-values.yaml

### install the helm chart from local helm repo after already adding it using the value files you downloaded using wget. helm upgrade -i allows you to  have the different apps in the stack in the same namespace. (using helm install only let you install one chart per namespace)
helm upgrade -i elasticsearch elastic/elasticsearch --namespace elastic-system --create-namespace
helm upgrade -i logstash elastic/logstash --namespace elastic-system --create-namespace
helm upgrade -i filebeat elastic/filebeat --namespace elastic-system --create-namespace
helm upgrade -i metricbeat elastic/metricbeat --namespace elastic-system --create-namespace
helm upgrade -i kibana elastic/kibana --namespace elastic-system --create-namespace

### Verify the installation 
kubectl get po -n elastic-system

### to see helm repo thats on your system 
helm repo list 

### after you add new repo
helm update

### To add elastic repo to local machine 
helm repo add elastic https://helm.elastic.co
helm repo update

###  Helm Repo's that need to be added for logging stack 
helm search repo elastic

elastic/elasticsearch
elastic/kibana
elastic/logstash
elastic/filebeat
elastic/metricbeat
elastic/apm-server

### To do list (ignore)
1. Logging 
2. Argocd 
3. Vault 
4. Service Mesh Istio

### To get password for elastic user 
 kubectl get secrets --namespace=elastic-system elasticsearch-master-credentials -ojsonpath='{.data.password}' | base64 -d



### To cleanup kibana
delete pods: k delete pods (podname) -n (namespace)

### To install logging tools (revised)
helm install elasticsearch elastic/elasticsearch -n elastic-system --create-namespace --set replicas=1
helm upgrade -i metricbeat elastic/metricbeat -n elastic-system 
helm upgrade -i filebeat elastic/filebeat -n elastic-system 
helm upgrade -i apm-server elastic/apm-server -n elastic-system 
helm upgrade -i logstash elastic/logstash -n elastic-system 
helm upgrade -i kibana elastic/kibana -n elastic-system 

kubectl -n elastic-system port-forward deployment/kibana-kibana 5601




```