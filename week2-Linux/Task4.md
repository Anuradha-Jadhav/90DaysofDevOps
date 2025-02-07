## Volume Management & Disk Usage

    Task:
        Create a directory /mnt/devops_data.
        Mount a new volume (or loop device for local practice).
        Verify using df -h and mount | grep devops_data.
### **Creating a New Volume on AWS EC2**  
####1. ** Click on Create Volume 

![image](https://github.com/user-attachments/assets/c310637d-e792-4d57-ac54-c40d41d68f2e)

### ** Give Volume Details like size and select the same availalbility zone as your VM to which you want to attach this volume
![image](https://github.com/user-attachments/assets/c3074da1-3c91-4163-adea-622c1f44fe6b)

### ** attach volume to VM
![image](https://github.com/user-attachments/assets/112ae9d2-bd14-4bc5-813e-6d41495b69b3)
### ** Select VM name from drop down and device name click on Attach
![image](https://github.com/user-attachments/assets/afef75a8-176b-4205-b64b-a80df04c327a)

If you’ve attached a new EBS volume to your AWS EC2 instance, follow these steps to mount it.

---



### **Step 1: Identify the Attached Volume**  
1. **List available disks:**  
   ```bash
   lsblk
   ```
   ![image](https://github.com/user-attachments/assets/4a794ceb-17b7-4af8-b8f6-da1692f6c79b)

   - `/dev/xvdbu` is the **new unmounted EBS volume**.  
  
---

### **Step 2: Format the Volume (if needed)**
If the volume is new and unformatted, format it as `ext4`:
```bash
sudo mkfs.ext4 /dev/xvdbu
```
> **⚠ Warning:** If the volume has existing data, **do not format it**! Skip this step.

---



### **Step 3: Create a Mount Point**
```bash
sudo mkdir -p /mnt/devops_data
```

---

### **Step 4: Mount the Volume**
```bash
sudo mount /dev/xvdbu /mnt/devops_data
```

---

### **Step 5: Verify the Mount**
Run:
```bash
df -h | grep devops_data
mount | grep devops_data
```
![image](https://github.com/user-attachments/assets/dc658376-68d3-4c68-8f9c-ee0abec531ee)

---

### **Step 6: Make the Mount Persistent (Across Reboots)**
1. Get the **UUID** of the volume:
   ```bash
   sudo blkid /dev/xvdbu
   ubuntu@ip-172-31-33-137:~$ sudo blkid /dev/xvdbu
   /dev/xvdbu: UUID="6169c8d7-1a7b-443e-9ab2-8f7905b76963" BLOCK_SIZE="4096" TYPE="ext4"
   ```
2. Add this line to `/etc/fstab`:

   ```bash
      echo 'UUID=6169c8d7-1a7b-443e-9ab2-8f7905b76963 /mnt/devops_data ext4 defaults,nofail 0 2' | sudo tee -a /etc/fstab
   ```
### Explanation of Each Field:
    1. UUID=abcd-1234-efgh-5678 → Identifies the volume uniquely (Replace with actual UUID from blkid).
    2. /mnt/devops_data → Mount point.
    3. ext4 → Filesystem type.
    4. defaults → Standard mount options:
    5. Read/write, allow execution, enable synchronous access, etc.
    6. nofail → Prevents boot failure if the device is missing.
    7. 0 → Dump backup option (usually 0 to disable).
    8. 2 → Filesystem check order (1 for root filesystem, 2 for others).
   

3. Test the fstab entry:
   ```bash
   sudo mount -a
   ```

---

### **Step 7: Set Permissions (If Required)**
If a specific user (`devops_user`) needs write access:
```bash
sudo chown devops_user:devops_user /mnt/devops_data
sudo chmod 755 /mnt/devops_data
```
![image](https://github.com/user-attachments/assets/4f3b28b8-264e-4bac-bfff-8af8227faef2)

---

### **Done! 🎉**  
Now, your AWS EBS volume is mounted and persists across reboots.
