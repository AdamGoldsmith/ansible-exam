# EX407 training material

Set of playbooks created to train for Ansible EX407 exam using this [online sample exam](https://www.lisenet.com/2019/ansible-sample-exam-for-ex407/)

## Preparation

### Create Ansible control machine

1. Created a CentOS 7 VM in VirtualBox
  * 4096 GB RAM
  * 16 GB VDI
  * 2 x network ports (NAT & Host-Only)
2. VirtualBox NAT Port Forward rule “SSH 127.0.0.1:2222 10.0.2.15:22”
3. Login as root
4. Created automation group & user
  * `groupadd automation`
  * `useradd -m -g automation automation`
5. Populate authorized_keys file
  * `su - automation`
  * `ssh-keygen`
  * `vi .ssh/authorized_keys`
  * Populate with public key of connecting user (putty) & save
  * `chmod 600 .ssh/authorized_keys`
7. Configure SUDO
  * `visudo`
  * Add following line
  `automation ALL=(ALL)       NOPASSWD: ALL`
8. Login as automation user from PuTTY
9. Update system
  * `sudo yum update -y`
  * `sudo reboot`

### Create Ansible target hosts

* Uses Vagrant + VirtualBox to create CentOS 7 Ansible targets.
* They are named ansible[2-5].h1.local
* 2 x network adatpers are created (NAT & Host-Only)
* IP addresses 10.1.44.[2-5] are assigned to them
* ansible5.h1.local has a 10GB disk file created for use in a later task

1. `cd vagrant`
2. `vagrant up`

## Tasks

#### Task 1 - Install Ansible in virtual environment
1. Login as automation user
2. `sudo yum install python3 -y`
3. `mkdir venvs`
4. `python3 -m venv ~/venvs/ansible`
5. `source ~/venvs/ansible/bin/activate`
6. `git clone https://github.com/AdamGoldsmith/ex407.git`
7. `cd plays`
8. `pip install -r requirements.txt`

#### Task 2 - Ad-hoc commands
1. `./adhoc.sh`

#### Task 3 - File content
1. ansible-playbook motd.yml

#### Task 4 - Configure SSH Server
1. ansible-playbook sshd.yml

#### Task 5 - Ansible vault
1. `echo "devops" > vault_key`
2. `chmod 600 vault_key`
3. `ansible-vault create secret.yml`
```
---

user_password: devops
database_password: devops
```

#### Task 6 - Users & groups
1. ansible-playbook users.yml

#### Task 7 - Scheduled tasks
1. ansible-playbook redular_tasks.yml

#### Task 8 - Software repositories
1. ansible-playbook repository.yml

#### Task 10 - Create and work with roles
1. ansible-playbook mysql.yml
__NB__ There are known issues with this playbook

#### Task 11 - Download roles from Ansible Galaxy
1. ansible-playbook haproxy.yml

#### Task 12 - Security
1. ansible-playbook selinux.yml

#### Task 13 - Use conditionals to control play execution
1. ansible-playbook sysctl.yml

#### Task 14 - Use archiving
1. ansible-playbook archive.yml

#### Task 15 - Work with Ansible facts
1. ansible-playbook facts.yml
[facts.d](https://docs.ansible.com/ansible/latest/user_guide/playbooks_variables.html#local-facts-facts-d)

#### Task 16 - Software packages
1. ansible-playbook packages.yml

#### Task 17 - Services
__NB__ Not completed yet

#### Task 18 - Create and use templates to create customised configuration files
1. ansible-playbook server_list.yml

## Known issues

1. Task 10 - MySQL problems with python version and CentOS
2. Task 17 - Not completed yet

## Documentation

Useful commands

* `ansible-doc`

`ansible-doc <module_name>` - display module information
`ansible-doc --list` - list all modules
`ansible-doc --list --type lookup` - list all lookups
`ansible-doc --list --type inventory` - list all inventory configurations
`ansible-doc yaml --type inventory` - display yaml inventory source information

## References

* [lvm](https://www.linuxsysadmins.com/creating-logical-volume-using-ansible/)

