#!/bin/bash
### Add prometheus stack helm to local helm repo 
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm pull prometheus-community/kube-prometheus-stack  --untar     

### Install the helm chart in the prometheus namespace using the values.yaml file 
helm upgrade -i monitoring prometheus-community/kube-prometheus-stack --namespace monitoring --create-namespace -f values.yaml

### Check the deployment
kubectl get all -n monitoring
kubectl get pod -n monitoring
kubectl get svc -n monitoring
kubectl get ing -n monitoring
kubectl get secret -n monitoring monitoring-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
kubectl get po -n monitoring | grep grafana

## to see if deployment is in stateful set 
k get statefulset -n (namespace)


### Edit the ingress section in the values.yaml file(change the host name to be configured with your domain name, below is just an example of what it might look like )
      kubernetes.io/spec.ingressClassName: nginx
      kubernetes.io/tls-acme: "true"

          ingressClassName: nginx
    hosts:
      - grafana.2waveyyy.com 


  ingress:
    ## If true, Grafana Ingress will be created
    ##
    enabled: true 
    ## IngressClassName for Grafana Ingress.
    ## Should be provided if Ingress is enable.
    ##
    # ingressClassName: nginx

    ## Annotations for Grafana Ingress
    ##
    annotations:
      kubernetes.io/spec.ingressClassName: nginx
      kubernetes.io/tls-acme: "true"

    ## Labels to be added to the Ingress
    ##
    labels: {}

    ## Hostnames.
    ## Must be provided if Ingress is enable.
    ##
    ingressClassName: nginx
    hosts:
      - grafana.2waveyyy.com
    # hosts: []
    ## Path for grafana ingress
    path: /


### Create an api url and change it in the helm chart to send your notifications to slack also change the channel name to the channel you created in slack (This is optional)
  slack_api_url: https://hooks.slack.com/services/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
