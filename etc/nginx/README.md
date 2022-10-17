# NGINX

- **Quick links of Docs:**
  - Server Block Examples: [Click here](https://www.nginx.com/resources/wiki/start/topics/examples/server_blocks/)
  - Full Example Configuration: [Click here](https://www.nginx.com/resources/wiki/start/topics/examples/full/)
  - Reverse Proxy: [Click here](https://docs.nginx.com/nginx/admin-guide/web-server/reverse-proxy/)

- **nginx beautifier:** 
  - Usage: `ng.b myFile`
  - Installation: `sudo npm install -g nginxbeautifier`. FYI: ng.b is alias in *.bash_aliases* file `alias ng.b='nginxbeautifier'`.

- Some aliaes you want to you(already in your `.bash_aliases` file):

```bash
alias vi.nginx='sudo nvim /etc/nginx/nginx.conf'

alias nginx.info='echo You can use vi.nginx, nx.testWatch, nx.test, nx.rWatch=restart-watch-nodemon, nx.r=restart, nx.s=status, nx.k=kill, nx.l=load i.e., start'
# nginx: r=restart, s=status, k=kill, l=load(start)
alias nx.r='sudo systemctl restart nginx.service'
alias nx.rWatch='nodemon -w /etc/nginx/nginx.conf -x "sudo systemctl restart nginx"'
alias nx.s='sudo systemctl status nginx.service'
alias nx.l='sudo systemctl start nginx.service'
alias nx.k='sudo systemctl stop nginx.service'
alias nx.test='sudo nginx -t'
alias nx.testWatch='nodemon -w /etc/nginx/nginx.conf -x "sudo nginx -t"'
```

- Proxy server vs. reverse proxy server?

SO Answer: [Click here](https://stackoverflow.com/a/366212/10012446)

Another Article: [Click here](https://www.strongdm.com/blog/difference-between-proxy-and-reverse-proxy)

tldr; They both do almost the same work i.e., acti between client and server.

crux: `forward (X --> Y) --> Z, reverse: X --> (Y --> Z)`

![image](https://user-images.githubusercontent.com/31458531/196049974-39eaa406-0484-4c6f-9c6a-1522198f2bb0.png)

![image](https://user-images.githubusercontent.com/31458531/196049952-72b4c7d4-dc94-4bce-b183-8b2e7a5a93b7.png)

