podTemplate(cloud: 'kubernetes',containers: [
    containerTemplate(name: 'tools', image: 'registry.cn-beijing.aliyuncs.com/dengyou/kube-ops:tools', ttyEnabled: true, command: 'cat'), 
    containerTemplate(name: 'maven3', image: 'registry.cn-beijing.aliyuncs.com/dengyou/kube-ops:maven3', command: 'cat', ttyEnabled: true),
    ],
    volumes: [
        hostPathVolume(hostPath: '/var/run/docker.sock', mountPath: '/var/run/docker.sock'),
        hostPathVolume(hostPath: '/root/.kube/', mountPath: '/root/.kube/'),
        hostPathVolume(hostPath: '/root/.docker', mountPath: '/root/.docker'),
        hostPathVolume(hostPath: '/data/repo', mountPath: '/usr/local/apache-maven/repo')
        // /data/repo 要手动创建出来，并给与相应的权限
    ]
)
{
   node(POD_LABEL) {
        stage('Clone'){
            container('tools') {
                echo "1. Clone Stage"
		checkout scm
		// git url: "https://github.com/imirsh/mvnweb-demo.git"
                script {
                    build_tag = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
                }
            }
        }
        stage('Package') {
            container('maven3') {
                echo "3. Package From Source Code"
                sh "mvn install"
            }
        }
        stage('Build') {
            container('tools') {
                echo "3. Build Docker Image Stage"
                sh "docker build -t registry.cn-beijing.aliyuncs.com/dengyou/mvnweb-demo:${build_tag} ."
            }
        }
        stage('Push') {
            container('tools') {
                echo "4. Push Docker Image Stage"
                // withCredentials([usernamePassword(credentialsId: 'registry.cn-beijing.aliyuncs.com_Auth', usernameVariable: 'aliUser',  passwordVariable: 'aliPassword')]) {
                //     sh "docker login -u ${aliUser} -p ${aliPassword} registry.cn-beijing.aliyuncs.com"
                //     sh "docker push registry.cn-beijing.aliyuncs.com/dengyou/jenkins-demo:${build_tag}"
                // }
                sh "docker push registry.cn-beijing.aliyuncs.com/dengyou/mvnweb-demo:${build_tag}"
        }
      }
        stage('YAML') {
            container('tools'){
                sh "sed -i 's@<BUILD_TAG>@${build_tag}@g' k8s.yaml"
                sh '/usr/local/bin/kubectl apply -f k8s.yaml --record'
            }
        }
    }
}
