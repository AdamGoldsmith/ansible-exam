# EX407 training material

Set of playbooks created to train for Ansible EX407 exam using this [online sample exam](https://www.lisenet.com/2019/ansible-sample-exam-for-ex407/) by Tomas of [Lisenet blog](https://www.lisenet.com/)

## Preparation

### Create Ansible control machine

Either use __WSL__ (Windows Subsystem for Linux) as your Ansible control machine, or use a VM as documented below:

1. Manually create a CentOS 7 VM in VirtualBox
  * 4096 GB RAM
  * 16 GB VDI
  * 2 x network ports (NAT & Host-Only)
2. VirtualBox NAT Port Forward rule "SSH 127.0.0.1:2222 10.0.2.15:22"
3. Login as root
4. Create automation group & user
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


### Clone the repo

1. `git clone https://github.com/AdamGoldsmith/ansible-exam.git`
2. `cd ansible-exam`

### Create Ansible target hosts

* Uses Vagrant + VirtualBox to create CentOS 7 Ansible targets.
* They are named ansible[2-5].h1.local
* 2 x network adapters are created (NAT & Host-Only)
* IP addresses 10.1.44.[2-5] are assigned to them respectively
* ansible5.h1.local has a 10GB disk file created for use in a later task

1. `cd vagrant`
2. Copy an SSH public key for post-build connectivity, eg  
`cp ~/.ssh/id_rsa.pub .`
3. `vagrant up`
4. `cd ..`

## Tasks


#### Task 1 - Install Ansible in virtual environment
1. Login as automation user
2. `sudo yum install python3 -y`
3. `mkdir venvs`
4. `python3 -m venv ~/venvs/ansible`
5. `source ~/venvs/ansible/bin/activate`
6. `cd ansible-exam`
7. `pip install -r requirements.txt`

#### Task 2 - Ad-hoc commands
1. `./adhoc.sh`

##### TLDR: Run all playbooks

At this point, as these playbooks are prefixed with numeric task number, the following command can be used to run all playbooks in the correct order:

```
ansible-playbook [0-9]*.yml
```

or you can choose to run them individually by skipping this command and running each of the following task's playbooks as follows.

#### Task 3 - File content
1. `ansible-playbook 03_motd.yml`

#### Task 4 - Configure SSH Server
1. `ansible-playbook 04_sshd.yml`

#### Task 5 - Ansible vault
These tasks have already been completed and the resultant files have been included in the repo.
1. `echo "devops" > vault_key`
2. `chmod 600 vault_key`
3. `ansible-vault create secret.yml`
```
---

user_password: devops
database_password: devops
```

[ansible-vault](https://docs.ansible.com/ansible/latest/user_guide/vault.html)

#### Task 6 - Users & groups
1. `ansible-playbook 06_users.yml`

#### Task 7 - Scheduled tasks
1. `ansible-playbook 07_regular_tasks.yml`

#### Task 8 - Software repositories
1. `ansible-playbook 08_repository.yml`

#### Task 09 - Create and work with roles
1. `ansible-playbook 09_mysql.yml`
__NB__ There are known issues with this playbook

#### Task 10 - Create and work with roles (some more)
1. `ansible-playbook 10_apache.yml`

#### Task 11 - Download roles from Ansible Galaxy
1. `ansible-playbook 11_haproxy.yml`

#### Task 12 - Security
1. `ansible-playbook 12_selinux.yml`

#### Task 13 - Use conditionals to control play execution
1. `ansible-playbook 13_sysctl.yml`

#### Task 14 - Use archiving
1. `ansible-playbook 14_archive.yml`

#### Task 15 - Work with Ansible facts
1. `ansible-playbook 15_facts.yml`

[facts.d](https://docs.ansible.com/ansible/latest/user_guide/playbooks_variables.html#local-facts-facts-d)

#### Task 16 - Software packages
1. `ansible-playbook 16_packages.yml`

#### Task 17 - Services
__NB__ Not completed yet

#### Task 18 - Create and use templates to create customised configuration files
1. `ansible-playbook 18_server_list.yml`

## Known issues

1. Task 09 - MySQL problems with python version and CentOS
2. Task 17 - Not completed yet

## Documentation

Useful commands

1. `ansible-doc`

* `ansible-doc <module_name>` - display module information
* `ansible-doc --list` - list all modules
* `ansible-doc --list --type lookup` - list all lookups
* `ansible-doc --list --type inventory` - list all inventory configurations
* `ansible-doc yaml --type inventory` - display yaml inventory source information

2. `ansible-config`

* `ansible-config list` - print all config options
* `ansible-config dump` - dump configuration
* `ansible-config view` - view configuration file

## References

* [lvm](https://www.linuxsysadmins.com/creating-logical-volume-using-ansible/)

