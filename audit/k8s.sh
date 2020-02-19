#!/bin/bash
KOPTS=""
#e.g.
#KOPTS=" --server=https://localhost:6443"

#semi-related - https://github.com/docker/docker-bench-security

echo "\n**********************\nGetting k8s version"
kubectl $KOPTS version

echo "\n**********************\nAre we running with enough privs?" 
kubectl $KOPTS auth can-i '*' '*'

echo "\n**********************\nGetting cluster info"
kubectl $KOPTS cluster-info
echo "\n**********************\nGetting cluster info dump"
kubectl $KOPTS cluster-info dump
echo "\n**********************\nGetting cluster roles"
kubectl $KOPTS get clusterroles
echo "\n**********************\nGetting all"
kubectl $KOPTS get all
echo "\n**********************\nGetting secrets"
kubectl $KOPTS get secrets
echo "\n**********************\nGetting ingresses"
kubectl $KOPTS get ing
echo "\n**********************\nGetting namespace"
kubectl $KOPTS get ns
echo "\n**********************\nGetting nodes"
kubectl $KOPTS get no
echo "\n**********************\nGetting pods"
kubectl $KOPTS get pods
echo "\n**********************\nGetting pod sec pol"
kubectl $KOPTS get psp
echo "\n**********************\nGetting namespace"
kubectl $KOPTS get ns
echo "\n**********************\nGetting service accounts"
kubectl $KOPTS get sa
echo "\n**********************\nGetting services"
kubectl $KOPTS get svc
echo "\n**********************\nGetting roles"
kubectl $KOPTS get roles
echo "\n**********************\nGetting rolebindings"
kubectl $KOPTS get rolebindings
echo "\n**********************\nGetting jobs"
kubectl $KOPTS get jobs
echo "\n**********************\nGetting component status"
kubectl $KOPTS get cs



echo "\n**********************\nDescribing cluster roles"
kubectl $KOPTS describe clusterroles
echo "\n**********************\nDescribing all"
kubectl $KOPTS describe all
echo "\n**********************\nDescribing secrets"
kubectl $KOPTS describe secrets
echo "\n**********************\nDescribing ingresses"
kubectl $KOPTS describe ing
echo "\n**********************\nDescribing namespace"
kubectl $KOPTS describe ns
echo "\n**********************\nDescribing nodes"
kubectl $KOPTS describe no
echo "\n**********************\nDescribing pods"
kubectl $KOPTS describe pods
echo "\n**********************\nDescribing pod sec pol"
kubectl $KOPTS describe psp
echo "\n**********************\nDescribing namespace"
kubectl $KOPTS describe ns
echo "\n**********************\nDescribing service accounts"
kubectl $KOPTS describe sa
echo "\n**********************\nDescribing services"
kubectl $KOPTS describe svc
echo "\n**********************\nDescribing roles"
kubectl $KOPTS describe roles
echo "\n**********************\nDescribing rolebindings"
kubectl $KOPTS describe rolebindings
echo "\n**********************\nDescribing jobs"
kubectl $KOPTS describe jobs
echo "\n**********************\nDescribing component status"
kubectl $KOPTS describe cs


# check if we can do things - 
#[mcn@ucore-node-1 ~]$ kubectl --server="https://172.17.70.19:6443" auth can-i '*' '*'
#yes
#[mcn@ucore-node-1 ~]$ kubectl --server="https://172.17.70.19:6443" auth can-i create pods
#yes
#[mcn@ucore-node-1 ~]$ kubectl --server="https://172.17.70.19:6443" auth can-i list pods
#yes
#[mcn@ucore-node-1 ~]$ kubectl --server="https://172.17.70.19:6443" auth can-i descibe pods
#yes
# etc
