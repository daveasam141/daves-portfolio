#!/bin/bash
kubectl create ns confluence
kubectl -n confluence create secret generic confluence-secret --from-literal=username='confluence' --from-literal=password='(input_password)' 
helm upgrade -i confluence atlassian-data-center/confluence --namespace confluence --create-namespace  --values confluence-values.yaml 

kubectl get pod -n confluence
kubectl get svc -n confluence
kubectl get ing -n confluence
kubectl describe pod confluence-0 -n confluence
kubectl get pod -n confluence -w