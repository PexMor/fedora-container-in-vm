#!/bin/bash

cat > tmp/meta-data << EOF
instance-id: Cloud00
local-hostname: cloud-00
EOF

cat > tmp/user-data << EOF
#cloud-config
# Set the default user
system_info:
  default_user:
    name: cloud

# Unlock the default user
chpasswd:
  list: |
     cloud:password
  expire: False

# Other settings
resize_rootfs: True
ssh_pwauth: True
timezone: Australia/Sydney

# Add any ssh public keys
ssh_authorized_keys:
 - ssh-rsa AAA...example...SDvZ user1@domain.com

bootcmd:
 - [ sh, -c, echo "=========bootcmd=========" ]
 
runcmd:
 - [ sh, -c, echo "=========runcmd=========" ]
 
# For pexpect to know when to log in and begin tests
final_message: "SYSTEM READY TO LOG IN"
EOF

cd tmp
genisoimage -output work-seed.iso -volid cidata -joliet -rock user-data meta-data
