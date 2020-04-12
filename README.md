# google-cloud-sql-proxy-test
# to define docker hub private repo to kubectl  
# http://docs.heptio.com/content/private-registries/pr-docker-hub.html

    $ docker login
    $ kubectl create secret docker-registry abdeldayem   $docker-username=abdeldayem   $docker-password=$Password   $docker-email=eng.amr.abdeldayem@gmail.com
    $ kubectl patch serviceaccount default   -p "{\"imagePullSecrets\": [{\"name\": \"abdeldayem\"}]}"

# to build docker image and push it on docker repo
    $ docker build -t abdeldayem/google-cloud-test:0.0.7.Release .
    $ docker push abdeldayem/google-cloud-test:0.0.7.Release
    
# to connect sql google cloud to kubectl by proxy
# https://www.youtube.com/watch?v=bN000CEg7IM
    $ gcloud sql users create proxyuser $host=cloudsqlproxy~% $instance=report $password=root
    $ kubectl create secret generic cloudsql-db-credentials $from-literal=username=proxyuser $from-literal=password=root
    $ kubectl create secret generic cloudsql-instance-credentials $from-file=credentials.json=striped-buckeye-272717-2551ce8b0cc2.json

# kubernaties command
    $ kubectl apply -f deployment.yaml
    $ kubectl get svc $watch
    $ kubectl delete all -l app=google-cloud-test
    $ kubectl cluster-info dump
    $ kubectl describe pod cloud-sql-proxy-d8f9797cc-zx76g
    
    $ kubectl create deployment google-cloud-test $image=abdeldayem/google-cloud-test:0.0.5.Release
    $ kubectl expose deployment google-cloud-test $type=LoadBalancer $port=8080
    $ kubectl get events $sort-by=.metadata.creationTimestamp
    $ kubectl delete all -l app=google-cloud-test
    
    $ gcloud sql connect report $user=root
    $ CREATE DATABASE google-cloud-test CHARACTER SET utf8 COLLATE utf8_general_ci;
    
    $ kubectl logs pod
    
# to set spring.datasource.url
    $ spring.datasource.url=jdbc:mysql://clouddb/report?useSSL=false&allowPublicKeyRetrieval=true&useUnicode=yes&characterEncoding=UTF-8
