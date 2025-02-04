

```markdown
## Creating a User, Adding to a Group, Setting a Password, and Granting Sudo Access

### Step 1: Create a New User `devops_user`

Create the user `devops_user` using the `useradd` command:
```bash
sudo useradd devops_user
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

### Step 4: Grant `devops_user` Sudo Access

Edit the sudoers file to grant `devops_user` sudo privileges:
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

Restrict SSH login for certain users in /etc/ssh/sshd_config
```bash
ubuntu@ip-172-31-38-99:~/.ssh$ sudo cat /etc/ssh/sshd_config | grep -i  deny
DenyUsers devops_user
ubuntu@ip-172-31-38-99:~/.ssh$
ubuntu@ip-172-31-38-99:~/.ssh$ sudo systemctl daemon-reload
ubuntu@ip-172-31-38-99:~/.ssh$ sudo systemctl restart ssh
```
### Summary

1. Created a user `devops_user`.
2. Created a group `devops_team` and added `devops_user` to it.
3. Set a password for `devops_user`.
4. Granted `devops_user` sudo access to allow for administrative tasks.
5. Verified the ability to use sudo to add new users.
```

This step-by-step guide will help you document the process for adding a user, assigning them to a group, setting a password, and granting them sudo access in a `README.md`. Let me know if you need further details!
