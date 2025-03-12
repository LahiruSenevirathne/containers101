#!/usr/bin/env bash

helm repo add metrics-server https://kubernetes-sigs.github.io/metrics-server/
helm upgrade --install metrics-server metrics-server/metrics-server --set-json 'args=["--kubelet-insecure-tls"]'
