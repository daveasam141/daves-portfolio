#!/bin/bash

### To uninstall Jira 
helm uninstall jira -n jira
kubectl delete ns jira 
kubectl get ns