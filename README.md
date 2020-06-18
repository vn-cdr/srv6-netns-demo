# srv6-linux-ground
One touch Build SRv6 Network Namespace with vagrant

## Topology
![](./srv6-netns.png)

## Run 
```
$ vagrant up
$ vagrant ssh
$ sudo su -
# bash scripts/01_create-namespaces.sh
# bash scripts/02_create-quagga.sh
# bash scripts/03_create-ospf6.sh
# bash scripts/04_create_srv6.sh
```

## how to use
```
$ ip netns exec host1 ping6 2001:db10::2


```
