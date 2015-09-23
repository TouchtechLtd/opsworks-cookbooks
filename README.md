opsworks-cookbooks
==================

#Patch nginx server with SSL security

- Forward Secrecy
- Diffie Hellman

requirements:
  - config via opswork chef
  - use custom nginx cookbooks

##With load balancer setup

Find your load balancer, in ``listner`` change cipher to use predefined security policy to

``ELBSecurityPolicy-2015-05``

##Without load balancer setup

* Go Opswork Stack


Run ``Update Custom cookbooks`` as stack command


* Deply an new version of your App

Run ``Deploy`` in your App layer


* SSH into the server

``sudo services nginx restart``

Testing with http://ssllabs.com/ssltest/