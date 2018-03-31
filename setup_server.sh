!/bin/bash

IMAGE_NAME=$1
PLATFORM=$2
SERVICE_ID=$3
SECRET_KEY=$4

ADMINIX_IMAGES_PATH=/tmp/adminix_images

if [ -d "$ADMINIX_IMAGES_PATH" ]; then
  rm -rf $ADMINIX_IMAGES_PATH
fi

mkdir $ADMINIX_IMAGES_PATH
curl -L https://github.com/adminixio/images/tarball/master | tar -xz --strip-components=1 -C $ADMINIX_IMAGES_PATH

if [ -d "$ADMINIX_IMAGES_PATH/$IMAGE_NAME/$PLATFORM" ]; then
  echo "Setting up a server..."
  chmod a+x $ADMINIX_IMAGES_PATH/$IMAGE_NAME/${PLATFORM}/bin/setup
  $ADMINIX_IMAGES_PATH/$IMAGE_NAME/${PLATFORM}/bin/setup
else
  echo "Wrong image name"
fi

if [ ! -z "$SERVICE_ID" ] && [ ! -z "$SECRET_KEY" ]; then
  echo "Generating Adminix credentials file..."
  mkdir -p ~/.config/adminix
  echo "{\"service_id\":\"${SERVICE_ID}\",\"secret_key\":\"${SECRET_KEY}\"}" >> ~/.config/adminix/credentials
fi
