#!/bin/bash

# @see Derived from https://github.com/GoogleChrome/rendertron/issues/775

GOOGLE_CLOUD_PROJECT=$1
REGION="asia-northeast1"
IMAGE="gcr.io/${GOOGLE_CLOUD_PROJECT}/rendertron"


# Build container image
gcloud \
    --project=${GOOGLE_CLOUD_PROJECT} \
    builds submit \
    --tag \
    $IMAGE

# Deploy service on Cloud Run
gcloud \
    --project=${GOOGLE_CLOUD_PROJECT} \
    run deploy \
    rendertron \
    --region=${REGION} \
    --allow-unauthenticated \
    --image $IMAGE