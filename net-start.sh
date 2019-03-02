#!/bin/bash
BRIDGE=br0
IF=enp0s20f0u2

echo "creating bridge: $BRIDGE"
ip link add name $BRIDGE type bridge &&\

echo "bringing up bridge: $BRIDGE"
ip link set $BRIDGE up &&\

echo "bringing up interface: $IF"
ip link set $IF up &&\

echo "adding interface into the bridge: $IF -> $BRIDGE"
ip link set $IF master $BRIDGE &&\

echo "dhclient requesting ip for bridge: $BRIDGE"
dhclient -v $BRIDGE
