version: "3"

services:
  web:
    image: ${REPO_URL}:${TAG}
    ports:
      - "80:5000"
