# the first stage of our build will use a maven 3.6.1 parent image
FROM maven:3.6.1-jdk-8-alpine AS MAVEN_BUILD

# copy the pom and src code to the container
COPY ./ ./

# package our application code
#RUN mvn clean package

# the second stage of our build will use open jdk 8 on alpine 3.9
FROM openjdk:8-jre-alpine3.9

# copy only the artifacts we need from the first stage and discard the rest
COPY --from=MAVEN_BUILD /target/google-cloud-test.jar /test.jar

# set the startup command to execute the jar
CMD ["java", "-jar", "/test.jar"]

# docker build -t abdeldayem/google-cloud-test:0.0.7.Release .
# docker push abdeldayem/google-cloud-test:0.0.7.Release

# docker login
# http://docs.heptio.com/content/private-registries/pr-docker-hub.html
# kubectl create secret docker-registry abdeldayem   --docker-username=abdeldayem   --docker-password=$password   --docker-email=eng.amr.abdeldayem@gmail.com
# kubectl patch serviceaccount default   -p "{\"imagePullSecrets\": [{\"name\": \"abdeldayem\"}]}"

# kubectl create deployment google-cloud-test --image=abdeldayem/google-cloud-test:0.0.5.Release
# kubectl expose deployment google-cloud-test --type=LoadBalancer --port=8080
# kubectl get events --sort-by=.metadata.creationTimestamp
# kubectl delete all -l app=google-cloud-test

# gcloud sql connect report --user=root
# CREATE DATABASE google-cloud-test CHARACTER SET utf8 COLLATE utf8_general_ci;

# kubectl logs pod
# https://github.com/GoogleCloudPlatform/cloud-sql-jdbc-socket-factory

# connect sql google cloud to kubectl by proxy
# https://www.youtube.com/watch?v=bN000CEg7IM
# gcloud sql users create proxyuser --host=cloudsqlproxy~% --instance=report --password=root
# kubectl create secret generic cloudsql-db-credentials --from-literal=username=proxyuser --from-literal=password=root
# kubectl create secret generic cloudsql-instance-credentials --from-file=credentials.json=striped-buckeye-272717-2551ce8b0cc2.json


# kubectl apply -f deployment.yaml
# kubectl get svc --watch
# kubectl delete all -l app=google-cloud-test
# kubectl cluster-info dump
# kubectl describe pod cloud-sql-proxy-d8f9797cc-zx76g
