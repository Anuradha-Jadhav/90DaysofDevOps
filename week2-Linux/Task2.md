
# File & Directory Permissions

    Task:
        1.Create /devops_workspace and a file project_notes.txt.
        2.Set permissions:
            Owner can edit, group can read, others have no access.
        3.Use ls -l to verify permissions.
  Here’s how you can accomplish each step:

---

### **Step 1: Create the Directory and File**
```bash
sudo mkdir /devops_workspace
sudo touch /devops_workspace/project_notes.txt
```

---

### **Step 2: Set Permissions**
1. **Set the owner to have write access (`rw-`)**
2. **Set the group to have read access (`r--`)**
3. **Deny access to others (`---`)**

Run:
```bash
sudo chmod 640 /devops_workspace/project_notes.txt
```

**Explanation of `chmod 640`:**  
- `6` (Owner: `rw-` → Read & Write)
- `4` (Group: `r--` → Read only)
- `0` (Others: `---` → No access)

---

### **Step 3: Verify Permissions**
```bash
ls -l /devops_workspace/project_notes.txt
```
Expected output:
```plaintext
-rw-r----- 1 your_user your_group 0 Feb 6 10:00 /devops_workspace/project_notes.txt
```

