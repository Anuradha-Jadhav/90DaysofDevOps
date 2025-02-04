

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

To restrict SSH login for certain users using the `/etc/ssh/sshd_config` file, you can use the `DenyUsers` directive.

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
   sudo nano /etc/ssh/sshd_config
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

