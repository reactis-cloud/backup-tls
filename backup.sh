#!/bin/bash
kubectl get secrets --all-namespaces --field-selector type=kubernetes.io/tls -o json | jq 'del(.items[].metadata.uid)' | jq 'del(.items[].metadata.resourceVersion)' | yq . - > tls.yaml
rclone copy tls.yaml b2:secret-tls
if [ $? -eq 0 ] && [ ! -z $OK_CALLBACK ] ; then
  curl --retry 3 $OK_CALLBACK
fi