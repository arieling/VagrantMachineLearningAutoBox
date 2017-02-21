# Vagrant－VirtualBox－WorkStation

A virtual box script containing Tensorflow-CPU, hadoop docker, python27, numpy and other machine leanring tools. 

## How to Istall

1. Install [virtual box](https://www.virtualbox.org/).
2. Install [vargant](https://www.vagrantup.com/)

## How to use:

1. Go to directory with Vagrantfile.
2. Type ```$ vagrant up ```  
3. Go and grabe a coffee, wait for a while.
4. Type ```$ vagrant halt ```
 and ```$ vagrant up ``` again.
 
## Set up Hadoop Clusters:

1. ```$ cd /docker_files/docker-ambari ```
2. switch to bash ```$ bash ```
3. Activate docker functions ```$ source ambari-functions```
4. Type ```$ amb-settings``` to make sure amb functions are working.
5. Start 3 clusters ```$ amb-start-cluster 3```
6. Go to ambari shell ```$ amb-shell```
7. type ```host list``` to make sure clusters are up.
8. add blueprint ```blueprint add --url https://raw.githubusercontent.com/sequenceiq/ambari-rest-client/2.2.11/src/main/resources/blueprints/multi-node-hdfs-yarn```
9. ```cluster autoAssign```
10. ```cluster create```

## Use tensorflow:

1. ```$ source activate tensorflow```
2. ```$ python```
3. ```> import tensorflow as tf```

## Useful vagrant command:

1. ```$ vagrant up ```  Setup virtual machine.
2. ```$ vagrant halt ``` Shut down virtual machine.
3. ```$ vagrant provision ``` Execute bootstrap.sh for debugging. 



## License

MIT License

