#!/usr/bin/env bash
rm ~/.ssh/known_hosts
rm ~/.ssh/known_hosts.old

ssh-keyscan -H 192.168.1.211 >> ~/.ssh/known_hosts
ssh-keyscan -H 192.168.1.212 >> ~/.ssh/known_hosts
ssh-keyscan -H 192.168.1.213 >> ~/.ssh/known_hosts
ssh-keyscan -H 192.168.1.214 >> ~/.ssh/known_hosts
ssh-keyscan -H 192.168.1.215 >> ~/.ssh/known_hosts
ssh-keyscan -H 192.168.1.216 >> ~/.ssh/known_hosts
#
pssh -h pssh_hosts -l gmirsky -i 'sudo dnf install python3.11 iptables -y'
#
