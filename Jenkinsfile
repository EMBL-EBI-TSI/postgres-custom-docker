#!/usr/bin/env groovy

node {

  stage('Checkout') {
    checkout scm
  }

  stage('Test') {
    dir('.') {
      sh 'test.sh'
	}
  }

  stage('Build') {
    docker.build("postgres-custom:${env.BUILD_ID}")
  }

}
