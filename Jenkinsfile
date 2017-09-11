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
  
    stage('Build') {
	  image = docker.build("postgres-custom:${env.BUILD_ID}")
	}
	
	stage('Test') {
	  def pg_port = 5436
	  def pg_user = 'test'
	  def pg_pwd  = 'testsecret'
	  image.withRun("-p ${pg_port}:5432 -e POSTGRES_USER=${pg_user} -e POSTGRES_PASSWORD=${pg_pwd}") {
	    sh PGPASSWORD=${pg_pwd} psql -h localhost -p ${pg_port} -u ${pg_user} postgres
	  }
	}
  }
  
}
