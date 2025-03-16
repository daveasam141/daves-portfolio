```sh
### Installing Elastic Stack using Helm 
helm repo add elastic https://helm.elastic.co
helm search repo elastic

### Create a directory for filebeat value file  and renanme it 
helm show values elastic/filebeat > filebeatvalues.yml 

### Get the logstash value file and rename it 
helm show values elastic/logstash > logstashvalues.yml 

### Get value file for Elasticaerch and rename it 
helm show values elastic/elasticsearch > elasticvalues.yml 

### Get value file for kibana and rename it 
helm show values elastic/kibana > kibanavalues.yml



### Deploy applications 
helm upgrade -i elasticsearch elastic/elasticsearch -f elasticvalues.yml -n logging --create-namespace
helm upgrade -i filebeat elastic/filebeat -f filebeatvalues.yml -n logging 
helm upgrade -i logstash elastic/logstash -f logstashvalues.yml -n logging 
helm upgrade -i kibana elastic/kibana -f kibanavalues.yml -n logging  































```