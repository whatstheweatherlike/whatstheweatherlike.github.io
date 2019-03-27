---
layout: post
title:  "Changed infrastructure to AWS ECS Cluster setup"
date:   2019-03-27 08:14:12 +0100
categories: aws terraform cloudflare backend service infrastucture
---

Due to some problems and missing features in the previous setup I migrated the backend service infrastructure to an [Elastic Container Service](https://docs.aws.amazon.com/ecs/index.html) cluster hosted in [AWS](http://aws.amazon.com). 

I should have evaluated the OpenShift Online solution better I guess, otherwise I wouldn't have experienced that automatic redeployment of updated docker images is a feature that OpenShift Online lacks (I guess this is a premium feature). What I also experienced was that the pods lacked observability, i.e. I couldn't find out why the hosted service failed on every second request, although it didn't on my local machine in MiniShift.

Therefore but also mainly because I was eager to refresh my knowledge of AWS and Terraform I created a setup that spins up an ECS cluster in AWS and deploys the backend application on it, then makes it accessible by an HTTPS enabled load balancer. All of this is done without bash glue code, solely with AWS and Terraform. 

There are a couple of parts required for this:
* A [VPC](https://aws.amazon.com/vpc/) (though this is not strictly required I wanted to have it separate from other infrastructure)
* Two ECS components
    * The [ECS cluster](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ECS_clusters.html) provides the container hosting
    * The [ECS Service](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs_services.html) that effectively provides the instances serving the requests
* a [bastion host](https://en.wikipedia.org/wiki/Bastion_host) that can be spun up if direct access to the EC2 instances is required  
* The application load balancer with attached certificate to provide the https access point
* The cloudflare configuration that is required to
  * point api.whatstheweatherlike.io the AWS ELB  
  * enable the certificate check for the generated ssl certificate
  
You can view the source code in the [service infrastructure repository on github](https://github.com/whatstheweatherlike/service-infrastructure): 
  
More in another post, have to go now. 