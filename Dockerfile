FROM jenkins/jenkins:lts

COPY --chown=jenkins target/configuration-as-code.hpi /usr/share/jenkins/ref/plugins/configuration-as-code.jpi
RUN echo $JENKINS_VERSION > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state
RUN echo $JENKINS_VERSION > /usr/share/jenkins/ref/jenkins.install.InstallUtil.lastExecVersion
ENV CASC_JENKINS_CONFIG=/usr/share/jenkins/ref/jenkins.yaml

# Derived image can just provide jenkins.yaml file in context, will be automatically included
ONBUILD COPY --chown=jenkins plugins.txt /usr/share/jenkins/ref/plugins.txt
ONBUILD RUN install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
ONBUILD COPY --chown=jenkins jenkins.yaml /usr/share/jenkins/ref/jenkins.yaml
