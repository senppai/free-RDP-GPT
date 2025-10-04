#!/usr/bin/env bash
# .devcontainer/start-desktop.sh

# set VNC password (insecure for demo — change for your use)
mkdir -p /root/.vnc
echo "0Pvny1TKaF@" | vncpasswd -f > /root/.vnc/passwd
chmod 600 /root/.vnc/passwd

# start a lightweight X session
export DISPLAY=":1"
Xvfb :1 -screen 0 1280x720x16 &

# start xfce session
startxfce4 &

# start a VNC server bound to display :1
tightvncserver :1 -geometry 1280x720 -localhost

# run websockify to bridge WebSocket to VNC port (5901)
/opt/noVNC/utils/websockify/run  --web /opt/noVNC 8080 localhost:5901
