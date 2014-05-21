#!/usr/bin/env bash
if [ -f "software/jboss-brms-installer-6.0.1.GA-redhat-4.jar" ]
then
        
	echo "Building docker image of JBoss BRMS 6.0.1 for test"
    #docker build --no-cache -t brms601:base .
	docker build -t brms601:base .
else
	echo "File software/jboss-brms-installer-6.0.1.GA-redhat-4.jar not found."
        echo "Please download JBoss BRMS 6.0.1 from http://jboss.org/products"
        exit 0
fi
