#!/bin/bash

# Create automation user and distribute SSH pub key to ansible hosts
# Remember to run ssh-keygen first. You will also need the SSH private key used by vagrant.

pubkey_file=~/.ssh/id_rsa.pub
username="automation"

[[ ! -e ${pubkey_file} ]] && echo "No public key (${pubkey_file}) detected, exiting" && exit 1

ansible proxy,webservers,database -u vagrant --private-key ~/.ssh/vagrant_rsa -b -m user -a "name=${username} state=present create_home=yes"
ansible proxy,webservers,database -u vagrant --private-key ~/.ssh/vagrant_rsa -b -m authorized_key -a "user=${username} state=present key={{ lookup('file', '${pubkey_file}') }}"
ansible proxy,webservers,database -u vagrant --private-key ~/.ssh/vagrant_rsa -b -m lineinfile -a "path=/etc/sudoers line='automation ALL=(ALL) NOPASSWD: ALL'"

# Install Geerlingguy's HAProxy Ansible role
# Has to be run in the "plays" directory where the roles_path is condifured in ansible.cfg
[[ ! -d roles ]] && mkdir roles
ansible-galaxy install geerlingguy.haproxy

