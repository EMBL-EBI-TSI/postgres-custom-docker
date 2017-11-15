#!/usr/bin/env groovy

node {
  def app

  stage('Checkout') {
    checkout scm
  }

  sh "git rev-parse HEAD > .git/commit-id"
  def commit_id = readFile('.git/commit-id').trim()
  println commit_id

  stage('Test') {
    sh 'chmod 755 ./test.sh'
    sh './test.sh'
  }

  stage('Build') {
    app = docker.build("ebitsi/postgres-logging")
  }

  stage('Publish') {
    /* Pushing multiple tags is cheap, as all the layers are reused. */
    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-ebitsi') {
      app.push("${commit_id}")
      app.push("latest")
    }
  }

}
