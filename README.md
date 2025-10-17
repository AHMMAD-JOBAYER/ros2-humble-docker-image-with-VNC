# 🐧 Ubuntu 22.04 + XFCE + VNC + ROS 2 Humble (Docker Image)

This repository provides a Dockerfile to build a containerized Ubuntu 22.04 (Jammy) environment with:

- A lightweight XFCE desktop  
- A VNC server (`tightvncserver`) for remote GUI access  
- ROS 2 Humble installed and ready to use  

The VNC implementation (desktop + password + server start logic) is largely based on the tutorial by Gustavo Lewin: *“How to make a Docker container with VNC access.”* :contentReference[oaicite:1]{index=1}

---

## 📦 What’s Included

| Component           | Description                                                                 |
|---------------------|-----------------------------------------------------------------------------|
| Base Image          | `ubuntu:22.04`                                                               |
| Desktop Environment | XFCE4                                                                        |
| VNC Server          | `tightvncserver` on port `5901`                                              |
| ROS 2 Version       | ROS 2 Humble desktop + dev tools                                             |
| VNC Password         | Default: `"password"` (change for security)                                  |

---

## 🏗️ Build Instructions

```bash
git clone https://github.com/your-username/your-repo-name.git
cd your-repo-name
docker build -t ros2-vnc .
````

---

## ▶️ Run Instructions

```bash
docker run -it --rm -p 5901:5901 ros2-vnc
```
Enjoy terminal or start vnc server by

```bash
cd ~/app
./start-vnc.sh
```

Then open a VNC viewer and connect to:

* **Address:** `localhost:5901`
* **Password:** `password` (default — change in Dockerfile)

You will see the XFCE desktop with ROS 2 Humble ready to use.

---

## 🧩 Customization Notes

* **Changing the VNC password:**
  In `Dockerfile`, modify:

  ```dockerfile
  echo "password" | vncpasswd -f > /root/.vnc/passwd
  ```

  Replace `"password"` with your desired password.

* **Resolution:**
  The environment variable `RESOLUTION` (default `1920x1080`) controls the VNC screen size.

---

## 📑 Acknowledgments

This project’s VNC setup is adapted from Gustavo Lewin’s article *“How to make a Docker container with VNC access”*. His guidance on installing XFCE, configuring `.vnc/passwd`, and scripting the VNC start command was extremely helpful. ([Medium][1])


[1]: https://medium.com/%40gustav0.lewin/how-to-make-a-docker-container-with-vnc-access-f607958141ae "How to make a Docker container with VNC access | by Gustavo Lewin | Medium"
