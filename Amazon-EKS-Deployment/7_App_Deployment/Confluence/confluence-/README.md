# confluence-
deploying confluence on EKS

### Foe the confluence-values.yaml file
change the database section to the mssql database that you create on ec2\
Change the domain name to your domain name iun the ingress section and make sure that ingress is enabled
Change the username and password for the secret in the install-confluence.sh file when installing confluence with 'helm upgrade'


