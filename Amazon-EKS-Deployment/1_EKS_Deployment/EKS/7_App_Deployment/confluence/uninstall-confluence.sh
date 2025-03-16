#!/bin/bash

### To delete a confluence
helm uninstall confluence -n confluence
kubectl delete ns confluence
kubectl get ns
