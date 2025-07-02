
## 2. **Commands to Create and Export NFS Directory on Master Node (Ubuntu Example)**

Here are the steps:

### **Step 1: Install NFS server**

```sh
sudo apt update
sudo apt install nfs-kernel-server -y
```

### **Step 2: Create directory to export**

```sh
sudo mkdir -p /srv/nfs/kubedata
sudo chown nobody:nogroup /srv/nfs/kubedata
sudo chmod 777 /srv/nfs/kubedata
```

### **Step 3: Configure the export**

Edit `/etc/exports` and add:

```
/srv/nfs/kubedata  *(rw,sync,no_subtree_check,no_root_squash)
```

Or run:

```sh
echo "/srv/nfs/kubedata *(rw,sync,no_subtree_check,no_root_squash)" | sudo tee -a /etc/exports
```

### **Step 4: Export the directory and restart NFS**

```sh
sudo exportfs -rav
sudo systemctl restart nfs-kernel-server
```

### **Step 5: Allow NFS through the firewall (if UFW enabled)**

```sh
sudo ufw allow from <worker_node_ip>/32 to any port nfs
sudo ufw reload
```

*(You can also allow from a whole subnet, e.g., `10.244.0.0/16`)*

---

## **Summary Table**

| Step                    | Command/Description                                            |
| ----------------------- | -------------------------------------------------------------- |
| Install NFS             | `sudo apt install nfs-kernel-server -y`                        |
| Create export directory | `sudo mkdir -p /srv/nfs/kubedata`                              |
| Configure export        | `/srv/nfs/kubedata *(rw,sync,no_subtree_check,...)`            |
| Export and restart NFS  | `sudo exportfs -rav; sudo systemctl restart nfs-kernel-server` |
| Update firewall         | `sudo ufw allow from <ip> to any port nfs`                     |

---

Let me know if you need:

* The **PersistentVolumeClaim** YAML as well,
* How to mount/test from the worker node,
* Or if you want this for CentOS/RHEL (commands change slightly)!
