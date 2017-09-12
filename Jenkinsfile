#!/usr/bin/env groovy

node {

  stage('Checkout') {
    checkout scm
  }

  stage('Test') {
    sh 'chmod 755 ./test.sh'
    sh './test.sh'
  }

  stage('Build') {
    /* Building multiple tags is cheap, as all the layers are reused. */
    docker.build("postgres-custom:${env.BUILD_ID}")
    docker.build("postgres-custom:latest")
  }

}
