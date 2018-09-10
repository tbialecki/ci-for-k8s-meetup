#!/bin/bash

gcloud config set project dev-ops-meetup
gcloud container clusters list

kubectl config current-context
kubectl config use-context

gcloud container clusters create "devops-meetup" --project "dev-ops-meetup" --zone "europe-west1-b" --username "admin" --cluster-version "1.10.6-gke.2" --machine-type "n1-standard-1" --image-type "COS" --disk-type "pd-standard" --disk-size "100" --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" --num-nodes "2" --enable-cloud-logging --enable-cloud-monitoring --network "projects/dev-ops-meetup/global/networks/default" --subnetwork "projects/dev-ops-meetup/regions/europe-west1/subnetworks/default" --addons HorizontalPodAutoscaling,HttpLoadBalancing,KubernetesDashboard --no-enable-autoupgrade --enable-autorepair
gcloud container clusters get-credentials "devops-meetup" --project "dev-ops-meetup" --zone "europe-west1-b"

kubectl config use-context gke_dev-ops-meetup_europe-west1-b_devops-meetup

docker build -f ./src/main/docker/Dockerfile -t eu.gcr.io/dev-ops-meetup/meetup-demo:0.0.1 ./build/libs

docker run -p 8080:8080 -it meetup-demo:0.0.1

docker login -u oauth2accesstoken -p "$(gcloud auth print-access-token)" https://eu.gcr.io

helm upgrade release-1 ./meetup-demo-chart/ -f ./meetup-demo-chart/values.yaml -i --force

helm upgrade release-1 ./meetup-demo-chart/ -f ./meetup-demo-chart/values.yaml -i --force --set-string image.version=0.0.1

kubectl set image deployment/meetup-demo meetup-demo=eu.gcr.io/dev-ops-meetup/meetup-demo:0.0.1

ab -n 20  "http://35.187.26.120/pi"