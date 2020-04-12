# google-cloud-sql-proxy-test


# to define docker hub private repo to kubectl  
# http://docs.heptio.com/content/private-registries/pr-docker-hub.html

 docker login
 kubectl create secret docker-registry abdeldayem   --docker-username=abdeldayem   --docker-password=$Password   --docker-email=eng.amr.abdeldayem@gmail.com
 kubectl patch serviceaccount default   -p "{\"imagePullSecrets\": [{\"name\": \"abdeldayem\"}]}"


