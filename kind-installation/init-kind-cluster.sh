#!/usr/bin/env bash

set -x

kind create cluster --config=kind-config.yaml --wait 1m
