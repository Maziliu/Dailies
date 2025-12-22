pipeline {
  agent any

  environment {
    JAVA_HOME = "/usr/lib/jvm/java-17-openjdk"
    ANDROID_SDK_ROOT = "/opt/android-sdk"
    ANDROID_HOME = "/opt/android-sdk"

    PATH = "/usr/lib/jvm/java-17-openjdk/bin:/usr/local/flutter/bin:/opt/android-sdk/platform-tools:/opt/android-sdk/cmdline-tools/latest/bin:${env.PATH}"
  }

  stages {

    stage('Environment Check') {
      steps {
        sh '''
          set -e
          echo "JAVA_HOME=$JAVA_HOME"
          java -version
          flutter --version
          echo "ANDROID_SDK_ROOT=$ANDROID_SDK_ROOT"
        '''
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

    stage('Flutter Pub Get') {
      steps {
        dir('dailies') {
          sh 'flutter pub get'
        }
      }
    }

    stage('Run Tests') {
      steps {
        dir('dailies') {
          sh 'flutter test --no-pub'
        }
      }
    }
  }

  post {
    success {
      echo 'Passed'
    }
    failure {
      echo 'Failed'
    }
  }
}
