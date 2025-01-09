# NGINX

- **Quick links of Docs:**
  - Server Block Examples: [Click here](https://www.nginx.com/resources/wiki/start/topics/examples/server_blocks/)
  - Full Example Configuration: [Click here](https://www.nginx.com/resources/wiki/start/topics/examples/full/)
  - Reverse Proxy: [Click here](https://docs.nginx.com/nginx/admin-guide/web-server/reverse-proxy/)
  - Reverse proxy with `express-http-proxy` (npm library): [sahilrajput03/reverseProxy](https://github.com/sahilrajput03/reverseProxy)

- **Usage of above files:**

	```bash
	sudo mv anyOfAboveFile /etc/nginx/nginx.conf
	```

- **nginx beautifier:** 
  - Usage: `ng.b myFile`
  - Installation: `sudo npm install -g nginxbeautifier`. FYI: ng.b is alias in *.bash_aliases* file `alias ng.b='nginxbeautifier'`.

- **All aliases and functions related to nginx:** [Click here](https://github.com/sahilrajput03/config/blob/main/.bash_nginx)

# (Forward) Proxy Server vs. Reverse Proxy Server

SO Answer: [Click here](https://stackoverflow.com/a/366212/10012446)

Another Article: [Click here](https://www.strongdm.com/blog/difference-between-proxy-and-reverse-proxy)

tldr; They both do almost the same work i.e., acti between client and server.

crux: `forward (X --> Y) --> Z, reverse: X --> (Y --> Z)`

## What is a proxy server?

A proxy server, sometimes referred to as a forward proxy, is a server that routes traffic between client(s) and another system, usually external to the network. By doing so, it can regulate traffic according to preset policies, convert and mask client IP addresses, enforce security protocols, and block unknown traffic.

## What is reverse proxy?

A reverse proxy is a type of proxy server. Unlike a traditional proxy server, which is used to protect clients, a reverse proxy is used to protect servers. A reverse proxy is a server that accepts a request from a client, forwards the request to another one of many other servers, and returns the results from the server that actually processed the request to the client as if the proxy server had processed the request itself. The client only communicates directly with the reverse proxy server and it does not know that some other server actually processed its request.
