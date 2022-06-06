#!/bin/bash

kubectl rollout restart deployment/java
 kubectl rollout status deployment/java
