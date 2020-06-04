[@Title]:<>(Kubernetes 负载均衡 添加跨域)
[@Date]:<>(2020-06-04 23:18:00)
[@Tags]:<>(kubernets,Cors)



负载均衡中添加注解



|                       键                       |                              值                              |
| :--------------------------------------------: | :----------------------------------------------------------: |
| nginx.ingress.kubernetes.io/cors-allow-headers | DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Authorization |
| nginx.ingress.kubernetes.io/cors-allow-methods |                   PUT, GET, POST, OPTIONS                    |
| nginx.ingress.kubernetes.io/cors-allow-origin  |                              *                               |
|    nginx.ingress.kubernetes.io/enable-cors     |                             true                             |