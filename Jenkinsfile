// https://github.com/Rudd-O/shared-jenkins-libraries
@Library('shared-jenkins-libraries@master') _

def test_step() {
    return {
        sh "make check"
    }
}

genericFedoraRPMPipeline(null, null, null, null, test_step())
