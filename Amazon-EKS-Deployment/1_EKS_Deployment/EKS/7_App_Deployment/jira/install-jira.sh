#!/bin/bash
kubectl create ns jira
kubectl create secret generic jira-secret --from-literal=username= 'usernameforjiradatabase' --from-literal=password='passwordforjiradatabase'
helm upgrade -i jira atlassian-data-center/jira --namespace jira --create-namespace --values jira-values.yaml 

kubectl get pod -n jira
kubectl get svc -n jira
kubectl get ing -n jira
kubectl describe pod jira-0 -n jira

