# NGINX

Usage of above files:

```bash
sudo mv anyOfAboveFile /etc/nginx/nginx.conf
```

- **Quick links of Docs:**
  - Server Block Examples: [Click here](https://www.nginx.com/resources/wiki/start/topics/examples/server_blocks/)
  - Full Example Configuration: [Click here](https://www.nginx.com/resources/wiki/start/topics/examples/full/)
  - Reverse Proxy: [Click here](https://docs.nginx.com/nginx/admin-guide/web-server/reverse-proxy/)

- **nginx beautifier:** 
  - Usage: `ng.b myFile`
  - Installation: `sudo npm install -g nginxbeautifier`. FYI: ng.b is alias in *.bash_aliases* file `alias ng.b='nginxbeautifier'`.

- **All aliases and functions related to nginx:** [Click here](https://github.com/sahilrajput03/config/blob/main/.bash_nginx)

- Proxy server vs. reverse proxy server?

SO Answer: [Click here](https://stackoverflow.com/a/366212/10012446)

Another Article: [Click here](https://www.strongdm.com/blog/difference-between-proxy-and-reverse-proxy)

tldr; They both do almost the same work i.e., acti between client and server.

crux: `forward (X --> Y) --> Z, reverse: X --> (Y --> Z)`

![image](https://user-images.githubusercontent.com/31458531/196049974-39eaa406-0484-4c6f-9c6a-1522198f2bb0.png)

![image](https://user-images.githubusercontent.com/31458531/196049952-72b4c7d4-dc94-4bce-b183-8b2e7a5a93b7.png)

