#!/usr/bin/env groovy

node {

  stage('Checkout') {
    checkout scm
  }

  stage('Test') {
    sh 'chmod 755 ./test.sh'
    bash './test.sh'
  }

  stage('Build') {
    docker.build("postgres-custom:${env.BUILD_ID}")
  }

}
