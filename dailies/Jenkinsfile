pipeline {
  agent any

  environment {
    FLUTTER_HOME = "/usr/local/flutter"
    PATH = "${FLUTTER_HOME}/bin:${env.PATH}"
  }

  options {
    timestamps()
    disableConcurrentBuilds()
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
        sh 'flutter pub get'
      }
    }

    stage('Run Tests') {
      steps {
        sh 'flutter test'
      }
    }

    stage('Build Release APKs') {
      when {
        tag pattern: "v*.*.*", comparator: "GLOB"
      }
      steps {
        sh 'flutter build apk --release --split-per-abi'
      }
    }
  }

  post {
    success {
      echo "Build succeeded"
    }
    failure {
      echo "Build failed"
    }
    always {
      archiveArtifacts artifacts: 'build/app/outputs/flutter-apk/*.apk', fingerprint: true
    }
  }
}
