pipeline {
    agent any
     triggers {
        pollSCM "* * * * *"
     }
    environment {
        GITHUB = credentials('NitinGithub')

    }

    stages {
        stage('Checkout') {
            steps{
                checkout scm
            }
        }
        stage('Build') {
            steps {
                sh 'mvn -B -DskipTests clean package'
            }
        }
         stage("Quality Gates SonarQube"){
		   steps {
		     sh "ls -lrt"
			 sh "chmod +x ./sonar.sh"
			 sh "ls -lrt"
			   sh "./sonar.sh"
                }
		}

        stage('Test') {
            steps {
                sh 'mvn test'
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }


        stage('Build Docker Image') {
                            when {
                                branch 'master'
                            }

                            steps {
                                echo '=== Building simple-java-maven-app Docker Image ==='
                                script {
                                    app = docker.build("jenkins_ecr")
                                }
                            }
                }
                stage('Push Docker Image') {
                            when {
                                branch 'master'
                            }
                            steps {
                                echo '=== Pushing simple-java-maven-app Docker Image ==='
                                script {
                                    GIT_COMMIT_HASH = sh (script: "git log -n 1 --pretty=format:'%H'", returnStdout: true)
                                    SHORT_COMMIT = "${GIT_COMMIT_HASH[0..7]}"
                                    docker.withRegistry('https://561337794842.dkr.ecr.us-east-2.amazonaws.com/jenkins_ecr:latest', 'ecr:us-east-2:d2f221f3-4515-46cc-800b-b089de98dbf3') {
    docker.image('jenkins_ecr').push('latest')
  }
                                }
                            }
                }
                
    }
}
