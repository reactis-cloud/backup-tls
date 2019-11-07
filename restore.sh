#!/bin/bash
rclone copy b2:secret-tls/tls.yaml tls.yaml
kubectl apply -f tls.yaml
if [ $? -eq 0 ] && [ ! -z $OK_CALLBACK ] ; then
  curl --retry 3 $OK_CALLBACK
fi