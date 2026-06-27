#!/usr/bin/env python3
import os
import pty
import sys
import select
import time

# SSH Command Configuration
# Using the verified key and settings
SSH_CMD = [
    "/usr/bin/ssh",
    "-tt",                                  # Force TTY allocation
    "-o", "ServerAliveInterval=60",         # Keep connection alive
    "-o", "ExitOnForwardFailure=yes",       # Exit if ports can't be bound
    "-o", "StrictHostKeyChecking=no",       # Don't prompt for host key
    "-o", "UserKnownHostsFile=/dev/null",   # Avoid known_hosts issues
    "-i", "/root/.ssh/id_runpod_ed25519",   # Identity Key
    "-L", "0.0.0.0:8188:127.0.0.1:8188",    # Port Forward: ComfyUI
    "-L", "0.0.0.0:7860:127.0.0.1:7860",    # Port Forward: SD WebUI
    "-p", "22",                             # Port
    "v3peju2d7q05xy-64411853@ssh.runpod.io",# Remote Host
    "echo 'Tunnel Established'; sleep infinity" # Keepalive command
]

def main():
    print(f"Starting Tunnel Wrapper: {' '.join(SSH_CMD)}")
    
    # Fork a child process with a pseudo-terminal
    # This makes SSH think it's running in a real interactive terminal
    pid, fd = pty.fork()

    if pid == 0:
        # Child process: Execute SSH
        try:
            os.execv(SSH_CMD[0], SSH_CMD)
        except OSError as e:
            sys.stderr.write(f"Error executing SSH: {e}\n")
            sys.exit(1)
    else:
        # Parent process: Monitor the child
        try:
            while True:
                # Check for output from child (non-blocking)
                r, _, _ = select.select([fd], [], [], 1.0)
                
                if fd in r:
                    try:
                        data = os.read(fd, 1024)
                        if not data:
                            break # EOF
                        # Log child output to systemd journal (stdout)
                        sys.stdout.buffer.write(data)
                        sys.stdout.buffer.flush()
                    except OSError:
                        break
                
                # Check if child process has exited
                wpid, status = os.waitpid(pid, os.WNOHANG)
                if wpid == pid:
                    # Child is gone
                    exit_code = os.WEXITSTATUS(status)
                    print(f"SSH process exited with code {exit_code}")
                    sys.exit(exit_code)
                    
        except KeyboardInterrupt:
            print("Stopping Tunnel...")
        finally:
            try:
                os.close(fd)
            except:
                pass

if __name__ == "__main__":
    main()
