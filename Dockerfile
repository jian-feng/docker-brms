#######################################################################
#                                                                     #
# Creates a base CentOS image with JBoss BRMS 6.0.1 #
#   docker run -P -i -t brms601 /bin/bash                             #
#######################################################################

# Use the centos base image
FROM centos

MAINTAINER Jian Feng <jfeng@redhat.com>

# Update the system
RUN yum -y update
RUN yum clean all

# enabling sudo group for jboss
RUN echo '%jboss ALL=(ALL) ALL' >> /etc/sudoers

# Create jboss user
RUN useradd -m -d /home/jboss -p jboss jboss


############################################
# Install Java JDK
############################################
RUN yum -y install java-1.7.0-openjdk
RUN yum clean all
ENV JAVA_HOME /usr/lib/jvm/jre


############################################
# Install JBoss BRMS 6.0.1
############################################
USER jboss
ENV HOME /home/jboss
ENV INSTALLDIR $HOME/brms
ENV ADMINPASSWORD Admin123!
ENV BRMSPASSWORD Admin123!

RUN mkdir $INSTALLDIR && \
   mkdir $INSTALLDIR/software && \
   mkdir $INSTALLDIR/support 

ADD ./software/jboss-brms-installer-6.0.1.GA-redhat-4.jar $INSTALLDIR/software/jboss-brms-installer-6.0.1.GA-redhat-4.jar 
ADD ./support/InstallScript.xml $INSTALLDIR/support/InstallScript.xml

RUN /usr/lib/jvm/jre/bin/java -jar $INSTALLDIR/software/jboss-brms-installer-6.0.1.GA-redhat-4.jar \
	$INSTALLDIR/support/InstallScript.xml \
	-variables adminPassword=$ADMINPASSWORD,brms.password=$BRMSPASSWORD

# Command line shortcuts
RUN echo "export JAVA_HOME=/usr/lib/jvm/jre" >> $HOME/.bash_profile
RUN echo "alias ll='ls -l --color=auto'" >> $HOME/.bash_profile
RUN echo "alias grep='grep --color=auto'" >> $HOME/.bash_profile
RUN echo "alias c='clear'" >> $HOME/.bash_profile

# startall.sh
USER root
RUN echo "#!/bin/sh" > $HOME/startall.sh
RUN echo "echo JBoss BRMS Start script" >> $HOME/startall.sh
RUN echo "runuser -l jboss -c '$HOME/brms/jboss-eap-6.1/bin/standalone.sh -c standalone.xml -b 0.0.0.0 -bmanagement 0.0.0.0'" >> $HOME/startall.sh
RUN chmod +x $HOME/startall.sh

# Clean up
RUN rm -rf $INSTALLDIR/support
RUN rm -rf $INSTALLDIR/software

EXPOSE 8080 9990

CMD /home/jboss/startall.sh

# Finished
