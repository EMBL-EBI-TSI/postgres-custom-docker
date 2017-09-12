#!/usr/bin/env groovy

node {

  stages {

    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Test') {
      steps {
        sh './test.sh'
      }
    }

    stage('Build') {
      steps {
        docker.build("postgres-custom:${env.BUILD_ID}")
      }
    }

  }

}
