## Process Management & Monitoring

    Task:
        1.Start a background process (ping google.com > ping_test.log &).
        2.Use ps, top, and htop to monitor it.
        3.Kill the process and verify it's gone.

    Here’s how you can complete each step:

---

### **Step 1: Start a Background Process**
Run the following command to start `ping` in the background and log the output to `ping_test.log`:
```bash
ping google.com > ping_test.log &
```
- The `&` at the end runs the process in the **background**.
- You should see an output like `[1] 12345`, where **12345** is the **Process ID (PID)**.
- ![image](https://github.com/user-attachments/assets/f164d627-8ee3-46ee-8a51-1e39eeeff1fc)


---

### **Step 2: Monitor the Process**

#### **Using `ps`**
List all running processes and filter for `ping`:
```bash
ps aux | grep ping
```

#### **Using `top`**
Run:
```bash
top
```
- Press `/` and type `ping` to search.
- Press `q` to exit.

#### **Using `htop`** (If installed)
Run:
```bash
htop
```
- Use the **arrow keys** to find `ping`.
- Press `F3` to search for `ping`.
- Press `q` to exit.
- ![image](https://github.com/user-attachments/assets/063f49f6-b7fe-41f0-ae38-2c5d212b4750)


> **If `htop` is not installed**, install it:
```bash
sudo apt update && sudo apt install htop -y
```

---

### **Step 3: Kill the Process and Verify**
1️⃣ **Find the PID**  
If you didn’t note the PID earlier, find it again:
```bash
ps aux | grep ping
```

2️⃣ **Kill the Process Using PID**  
Replace `12345` with the actual PID:
```bash
kill 6454

```
To force kill (if needed):
```bash
kill -9 6454
```

3️⃣ **Verify the Process is Gone**
```bash
ps aux | grep ping
```
If no output appears (except for `grep ping` itself), the process is successfully terminated.

---

✅ **Done!** You’ve started, monitored, and killed a background process. 
