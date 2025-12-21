pipeline {
  agent any

  environment {
    PATH = "/usr/local/flutter/bin:${env.PATH}"
  }

  stages {

    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Flutter Info') {
      steps {
        sh 'flutter --version'
      }
    }

    stage('Get Dependencies') {
      steps {
        dir('dailies') {
          sh 'flutter pub get'
        }
      }
    }

    stage('Run Tests') {
      steps {
        dir('dailies') {
          sh 'flutter test'
        }
      }
    }

    stage('Build Release APKs') {
      when {
        tag pattern: "v*.*.*", comparator: "GLOB"
      }
      steps {
        dir('dailies') {
          sh 'flutter build apk --release --split-per-abi'
        }
      }
    }
  }

  post {
    success {
      script {
        if (env.TAG_NAME) {
          archiveArtifacts(
            artifacts: 'dailies/build/app/outputs/flutter-apk/*.apk',
            fingerprint: true
          )
        }
      }
    }

    failure {
      echo 'Build failed'
    }
  }
}
