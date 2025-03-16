```sh
 
database:
  type: mssql
  url: jdbc:sqlserver://mssql.solvweb.net:1433;databaseName=confluence
  driver: com.microsoft.sqlserver.jdbc.SQLServerDriver
  credentials:
    secretName: confluence 
    usernameSecretKey: username
    passwordSecretKey: password


#!/bin/bash
kubectl create ns confluence-test 
kubectl -n confluence-test create secret generic confluence-secret --from-literal=username='confluencetest' --from-literal=password='confluencetest'
helm upgrade -i confluence-test atlassian-data-center/confluence --namespace confluence-test --create-namespace  --values confluence-values.yaml 
kubectl get pod -n confluence-test
kubectl get svc -n confluence-test
kubectl get ing -n confluence-test
kubectl describe pod confluence-test-0 -n confluence-test
kubectl get pod -n confluence-test -w

```

### To check logs for troubleshooting 
kubectl logs -f <pod_name> -n <namespace>

### To check pods for troubleshooting
kubectl describe pod confluence-test-0 -n confluence-test

### if website keeps crashing could be a resource issue, so check the cpu values in the yaml file 
use 2cpu and 4g memory(proven to work)

When setting up an application using helm charts you don't need to apply manifest files instead you use the helm install command 