pipeline {
  agent any

  environment {
    PATH = "/usr/local/flutter/bin:${env.PATH}"
    GH_TOKEN = credentials('github-token')
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

    stage('Create CI .env') {
      steps {
        dir('dailies') {
          sh '''
            cat <<EOF > .env
ENV=ci
BACKEND_URL=https://example.invalid
SERVER_PASSWORD=fake-password
EOF
          '''
        }
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

    stage('Create GitHub Release') {
      when {
        tag pattern: "v*.*.*", comparator: "GLOB"
      }
      steps {
        sh '''
          gh release create "$TAG_NAME" \
            dailies/build/app/outputs/flutter-apk/*.apk \
            --title "$TAG_NAME" \
            --notes "Automated release for $TAG_NAME"
        '''
      }
    }
  }

  post {
    failure {
      echo 'Build failed'
    }
  }
}
