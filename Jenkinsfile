#!/usr/bin/env groovy

pipeline {

  agent {
    dockerfile true
  }

  stages {
    def image;

    stage('Checkout') {
	  checkout scm
	}

	stage('Test') {
	 sh ./test.sh
	}

    stage('Build') {
	  image = docker.build("postgres-custom:${env.BUILD_ID}")
	}
  }

}
