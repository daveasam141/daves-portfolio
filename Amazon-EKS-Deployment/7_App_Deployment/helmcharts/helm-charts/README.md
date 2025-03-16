# helm-charts
```sh
### To create helm chart from scratch 
helm create (chartname)
helm create homesite 

### Navigate to the created helm chart 
cd (app-name)
cd homesite 

### Edit the Chart.yaml file
change app name and everything else you would like to change 

### For the templates folder(will contain the manifests for your application) you can remove all default files from this directory and add your own
rm -rf templates/* (The * removes all files the specified directory)


### Create a deployment file and make a template out of it using the object parameter inside curly braces 
{{ .Object.Parameter }}

### To verify the helm chart that you just created (that they have the right indentations and to verify the validity of the helm chart you created  )
helm lint .

### To validate if the values are getting added to the templates (This would generate and display all the manifest files with the substituted values)
helm template .

### To try to install the chart to the cluster to see if there are any errors in the helm chart (Kind of like a trial test, make sure you are in the directory above the application directory) THis would give you an output of the manifest that would get deployed in the cluster if there is no error
helm install --dry-run my-release (chartname)
helm install --dry-run my-release homesite 

### To install helm chart 
helm install (chartname)
helm install my-release homesite 

### References 
https://devopscube.com/create-helm-chart/
https://helm.sh/docs/helm/helm_create/

### Personal access token for helm  chart repo on my github 














```