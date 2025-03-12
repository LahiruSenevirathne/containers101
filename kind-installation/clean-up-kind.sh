#!/usr/bin/env bash

CLUSTER_NAME=$(yq .name <kind-config.yaml)
kind delete cluster --name "${CLUSTER_NAME}"
