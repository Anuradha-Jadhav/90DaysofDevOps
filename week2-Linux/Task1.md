



### Creating a User, Adding to a Group, Setting a Password, and Granting Sudo Access

### Step 1: Create a New User `devops_user`

Create the user `devops_user` using the `useradd` command -m to assign home directory and -s for default shell:
```bash
sudo useradd -m -s /bin/bash devops_user  
```

Verify the user has been created:
```bash
id devops_user
```

You should see output similar to:
```bash
uid=1002(devops_user) gid=1002(devops_user) groups=1002(devops_user)
```

Check the `/etc/passwd` file for the new user:
```bash
cat /etc/passwd | grep devops_user
```

This should return something like:
```bash
devops_user:x:1002:1002::/home/devops_user:/bin/sh
```

### Step 2: Create a New Group `devops_team` and Add the User to It

Create a new group called `devops_team`:
```bash
sudo groupadd devops_team
```

Verify the group has been created:
```bash
cat /etc/group | grep devops_team
```

You should see output similar to:
```bash
devops_team:x:1003:
```

Add `devops_user` to the `devops_team` group:
```bash
sudo usermod -aG devops_team devops_user
```

Check the user’s group membership:
```bash
id devops_user
```

The output should now include `devops_team`:
```bash
uid=1002(devops_user) gid=1002(devops_user) groups=1002(devops_user),1003(devops_team)
```

### Step 3: Set a Password for `devops_user`

Set a password for `devops_user`:
```bash
sudo passwd devops_user
```

You will be prompted to enter a new password for the user.

### Step 4: Grant `devops_user` Sudo Access Not recommended
**1) Adding User in sudo group
  ```bash
   sudo usermod -aG sudo devops_user
```
**2) Edit the sudoers file to grant `devops_user` sudo privileges:
```bash
sudo vim /etc/sudoers
```

Add the following line at the appropriate place in the file:
```bash
devops_user     ALL=(ALL:ALL) ALL
```

Verify the changes by checking the sudoers file:
```bash
sudo cat /etc/sudoers | grep devops_user
```

You should see the line granting sudo access:
```bash
devops_user     ALL=(ALL:ALL) ALL
```

### Step 5: Switch to `devops_user` and Verify Sudo Access

Switch to `devops_user`:
```bash
su devops_user
```

Verify the current user:
```bash
whoami
```

This should return:
```bash
devops_user
```

Test the ability to add a new user. Try to run the `useradd` command without `sudo`:
```bash
useradd mona
```

You should see:
```bash
useradd: Permission denied.
useradd: cannot lock /etc/passwd; try again later.
```

Now, try adding a new user with `sudo`:
```bash
sudo useradd mona
```

You’ll be prompted for `devops_user`'s password. After entering the correct password, the user `mona` will be created:
```bash
id mona
```

You should see:
```bash
uid=1003(mona) gid=1004(mona) groups=1004(mona)
```

To restrict SSH login for certain users using the `/etc/ssh/sshd_config` file, you can use the `DenyUsers` directive.
### Steps to  SSH Login on Remote server or using different user in same machine

1.** switch to user you want take ssh from
```
ubuntu@ip-172-31-33-137:~$ su devops_user
Password:
devops_user@ip-172-31-33-137:~$ mkdir  -p .ssh
devops_user@ip-172-31-33-137:~$ touch .ssh/authorized_keys
devops_user@ip-172-31-33-137:~$ pwd
/home/devops_user
devops_user@ip-172-31-33-137:~$
```

On Remote server take public key and copy public key on ssh client (the user you want to take ssh from)
```
ubuntu@ip-172-31-33-137:~/.ssh$ cat id_rsa.pub

ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDTlx+TVPKMwS/Gs7LNPFuvE683XEwrunw2uT1KpTiyPbq2vRZLPBUB+7EPaAEbTECVtxtXskdQOF4cx4EgY5UhWoyKJRbqAgyHPaHVD/Gf/8OpbpH3ZPJVHxRPOYOB9XfgC6fKiUglKwPC02x9VUljM0N2nviBKSUlbssYhjVR6r+b1XpamHg+aHWpa/9jOm7vAW/5JdupNWRSzlw7bWTqAY3yFVPND2taSpOxSChrVUFNvQzHgzRKSqB9rJ9yZkb9qrT/7N0vGX472Gebr/qcOf0wbQ4I5yVoX1pApxkFD035MamTxq8DhCXUuH8ii420IEx0Ncfm7tZe+DtGlOTzcCyRMd19gEI7oGUWrbZElAwqijsZIQ5JbgBOjtN2UwfAO2C0N7Vd8rXRGQ6KiAfMFn0/MTCMnc5ZRWwgpRU3EPy0EuBBUBpkffsvh8fnpE7GFMyWemQ3rzPO0jqvG6ca4VTN1n6MB14R+5sI0D0eP0UVb3tUUhXJeAEJw/GfPgU= ubuntu@ip-172-31-33-137
```
```
ubuntu@ip-172-31-33-137:~/.ssh$ su devops_user
Password:
devops_user@ip-172-31-33-137:/home/ubuntu/.ssh$ vi /home/devops_user/.ssh/authorized_keys
devops_user@ip-172-31-33-137:/home/ubuntu/.ssh$ cat /home/devops_user/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDTlx+TVPKMwS/Gs7LNPFuvE683XEwrunw2uT1KpTiyPbq2vRZLPBUB+7EPaAEbTECVtxtXskdQOF4cx4EgY5UhWoyKJRbqAgyHPaHVD/Gf/8OpbpH3ZPJVHxRPOYOB9XfgC6fKiUglKwPC02x9VUljM0N2nviBKSUlbssYhjVR6r+b1XpamHg+aHWpa/9jOm7vAW/5JdupNWRSzlw7bWTqAY3yFVPND2taSpOxSChrVUFNvQzHgzRKSqB9rJ9yZkb9qrT/7N0vGX472Gebr/qcOf0wbQ4I5yVoX1pApxkFD035MamTxq8DhCXUuH8ii420IEx0Ncfm7tZe+DtGlOTzcCyRMd19gEI7oGUWrbZElAwqijsZIQ5JbgBOjtN2UwfAO2C0N7Vd8rXRGQ6KiAfMFn0/MTCMnc5ZRWwgpRU3EPy0EuBBUBpkffsvh8fnpE7GFMyWemQ3rzPO0jqvG6ca4VTN1n6MB14R+5sI0D0eP0UVb3tUUhXJeAEJw/GfPgU= ubuntu@ip-172-31-33-137

devops_user@ip-172-31-33-137:/home/ubuntu/.ssh$
```

##### Take ssh of devops_user from ubuntu user on same server by using ssh command and pass the private key and public key is already copied in .ssh/authorized_keys
```
devops_user@ip-172-31-33-137:/home/ubuntu/.ssh$ exit
exit
ubuntu@ip-172-31-33-137:~/.ssh$ cd
ubuntu@ip-172-31-33-137:~$ ssh -i .ssh/id_rsa  devops_user@localhost
The authenticity of host 'localhost (127.0.0.1)' can't be established.
ED25519 key fingerprint is SHA256:0ty6dL4Lgzu2egMKho99TJaiTmhj8xfC5bvDPgF/v4A.
This host key is known by the following other names/addresses:
    ~/.ssh/known_hosts:2: [hashed name]
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'localhost' (ED25519) to the list of known hosts.
Welcome to Ubuntu 24.04.1 LTS (GNU/Linux 6.8.0-1021-aws x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Fri Feb  7 04:46:46 UTC 2025

  System load:  0.16              Processes:             113
  Usage of /:   26.7% of 6.71GB   Users logged in:       1
  Memory usage: 22%               IPv4 address for enX0: 172.31.33.137
  Swap usage:   0%


Expanded Security Maintenance for Applications is not enabled.

0 updates can be applied immediately.

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status


The list of available updates is more than a week old.
To check for new updates run: sudo apt update


The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

devops_user@ip-172-31-33-137:~$

```
### U should copy Public key on Remote Server you want access it using SSH and send private key while taking access with ssh command(Public key is like LOCK and your private key is KEY to you LOCK to get thorugh SSH)====================


### Steps to Restrict SSH Login for Specific Users

1. **Edit the SSH Configuration File**:
   To deny access for specific users via SSH, you can modify the `sshd_config` file. For example, to restrict login for `devops_user`, you would edit the file like this:

   ```bash
   sudo vi /etc/ssh/sshd_config
   ```

2. **Add the `DenyUsers` Directive**:
   In the `sshd_config` file, add the `DenyUsers` directive followed by the username(s) you want to block from SSH access. For example:

   ```bash
   DenyUsers devops_user
   ```

   This line will deny SSH access for the user `devops_user`.

3. **Reload the System Daemon**:
   After modifying the configuration, reload the system daemon to apply changes:

   ```bash
   sudo systemctl daemon-reload
   ```

4. **Restart the SSH Service**:
   Restart the SSH service to apply the changes:

   ```bash
   sudo systemctl restart ssh
   ```

5. **Verify the Configuration**:
   You can verify that the `DenyUsers` directive is properly set by running:

   ```bash
   sudo cat /etc/ssh/sshd_config | grep -i deny
   ```

   This should return:
   ```bash
   DenyUsers devops_user
   ```

### Testing the Restriction

Once you've restricted the user `devops_user` using the `DenyUsers` directive, try to log in via SSH with that user:

```bash
ssh devops_user@your_server_ip
```

You should receive a "Permission denied" error message.

### Explanation for `README.md`

Here’s the explanation you can add to your `README.md` for restricting SSH access:

```markdown
## Restricting SSH Login for Specific Users

To deny SSH login for specific users, follow these steps:

1. **Edit the SSH Configuration**:
   Open the SSH configuration file:

   ```bash
   sudo vi /etc/ssh/sshd_config
   ```

2. **Add the `DenyUsers` Directive**:
   Add the following line to deny SSH access for a specific user (e.g., `devops_user`):

   ```bash
   DenyUsers devops_user
   ```

3. **Reload System Daemon and Restart SSH**:
   After saving the file, reload the system daemon and restart the SSH service:

   ```bash
   sudo systemctl daemon-reload
   sudo systemctl restart ssh
   ```

4. **Verify the Restriction**:
   Ensure the `DenyUsers` directive has been applied by checking the configuration:

   ```bash
   sudo cat /etc/ssh/sshd_config | grep -i deny
   ```

   You should see the restricted user listed, for example:

   ```bash
   DenyUsers devops_user
   ```

### Testing

To test, try logging in as the restricted user via SSH:

```bash
ssh devops_user@your_server_ip
```

You should receive a "Permission denied" message.
```

This provides a comprehensive guide for restricting SSH login for specific users. Let me know if you need any further details!
### Summary

1. Created a user `devops_user`.
2. Created a group `devops_team` and added `devops_user` to it.
3. Set a password for `devops_user`.
4. Granted `devops_user` sudo access to allow for administrative tasks.
5. Verified the ability to use sudo to add new users.
```

