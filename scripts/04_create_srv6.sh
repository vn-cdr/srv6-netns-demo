#!/bin/bash

# seg6_enable for srv6-1
ip netns exec srv6-1 sysctl net.ipv6.conf.all.forwarding=1
ip netns exec srv6-1 sysctl net.ipv6.conf.all.seg6_enabled=1
ip netns exec srv6-1 sysctl net.ipv6.conf.default.seg6_enabled=1
ip netns exec srv6-1 sysctl net.ipv6.conf.veth-sr1-sr2.seg6_enabled=1
ip netns exec srv6-1 sysctl net.ipv6.conf.veth-sr1-ip1.seg6_enabled=1
ip netns exec srv6-1 sysctl -a | grep seg6

# seg6_enable for srv6-2
ip netns exec srv6-2 sysctl net.ipv6.conf.all.forwarding=1
ip netns exec srv6-2 sysctl net.ipv6.conf.all.seg6_enabled=1
ip netns exec srv6-2 sysctl net.ipv6.conf.default.seg6_enabled=1
ip netns exec srv6-2 sysctl net.ipv6.conf.veth-sr2-sr1.seg6_enabled=1
ip netns exec srv6-2 sysctl net.ipv6.conf.veth-sr2-ip1.seg6_enabled=1
ip netns exec srv6-2 sysctl net.ipv6.conf.veth-sr2-sr3.seg6_enabled=1
ip netns exec srv6-2 sysctl -a | grep seg6

# seg6_enable for srv6-3
ip netns exec srv6-3 sysctl net.ipv6.conf.all.forwarding=1
ip netns exec srv6-3 sysctl net.ipv6.conf.all.seg6_enabled=1
ip netns exec srv6-3 sysctl net.ipv6.conf.default.seg6_enabled=1
ip netns exec srv6-3 sysctl net.ipv6.conf.veth-sr3-sr2.seg6_enabled=1
ip netns exec srv6-3 sysctl net.ipv6.conf.veth-sr3-sr5.seg6_enabled=1
ip netns exec srv6-3 sysctl net.ipv6.conf.veth-sr3-sr6.seg6_enabled=1
ip netns exec srv6-3 sysctl net.ipv6.conf.veth-sr3-ip2.seg6_enabled=1
ip netns exec srv6-3 sysctl net.ipv6.conf.veth-sr3-sr4.seg6_enabled=1
ip netns exec srv6-3 sysctl -a | grep seg6

# seg6_enable for srv6-4
ip netns exec srv6-4 sysctl net.ipv6.conf.all.forwarding=1
ip netns exec srv6-4 sysctl net.ipv6.conf.all.seg6_enabled=1
ip netns exec srv6-4 sysctl net.ipv6.conf.default.seg6_enabled=1
ip netns exec srv6-4 sysctl net.ipv6.conf.veth-sr4-sr3.seg6_enabled=1
ip netns exec srv6-4 sysctl net.ipv6.conf.veth-sr4-ip2.seg6_enabled=1
ip netns exec srv6-4 sysctl -a | grep seg6

# seg6_enable for srv6-5
ip netns exec srv6-5 sysctl net.ipv6.conf.all.forwarding=1
ip netns exec srv6-5 sysctl net.ipv6.conf.all.seg6_enabled=1
ip netns exec srv6-5 sysctl net.ipv6.conf.default.seg6_enabled=1
ip netns exec srv6-5 sysctl net.ipv6.conf.veth-sr5-sr3.seg6_enabled=1
ip netns exec srv6-5 sysctl -a | grep seg6

# seg6_enable for srv6-6
ip netns exec srv6-6 sysctl net.ipv6.conf.all.forwarding=1
ip netns exec srv6-6 sysctl net.ipv6.conf.all.seg6_enabled=1
ip netns exec srv6-6 sysctl net.ipv6.conf.default.seg6_enabled=1
ip netns exec srv6-6 sysctl net.ipv6.conf.veth-sr6-sr3.seg6_enabled=1
ip netns exec srv6-6 sysctl -a | grep seg6

### DEMO(1)
# Encap(srv6-1)
ip netns exec srv6-1 ip -6 route add 2001:db10::/64 encap seg6 mode encap segs 2001:db2::2,2001:db5::2,2001:db8::2 dev veth-sr1-sr2
ip netns exec srv6-1 ip -6 route add 2001:db2::1/128 encap seg6local action End.DX6 nh6 2001:db1::1 dev veth-sr1-h1

# Transit(srv6-2)
ip netns exec srv6-2 ip -6 route add 2001:db2::2/128 encap seg6local action End dev veth-sr2-sr3
ip netns exec srv6-2 ip -6 route add 2001:db5::1/128 encap seg6local action End dev veth-sr2-sr1

# Transit(srv6-3)
ip netns exec srv6-3 ip -6 route add 2001:db5::2/128 encap seg6local action End dev veth-sr3-sr4
ip netns exec srv6-3 ip -6 route add 2001:db8::1/128 encap seg6local action End dev veth-sr3-sr2

# Endpoint(srv6-4)
ip netns exec srv6-4 ip -6 route add 2001:db8::2/128 encap seg6local action End.DX6 nh6 2001:db10::2 dev veth-sr4-h2
ip netns exec srv6-4 ip -6 route add 2001:db1::/64 encap seg6 mode encap segs 2001:db8::1,2001:db5::1,2001:db2::1 dev veth-sr4-sr3


### DEMO(2)

