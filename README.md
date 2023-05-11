[English Version](https://github.com/nenew/openai-api/blob/main/README_EN.md "English Version")
# 使用方法:
```bash
docker pull nenew/openai-api
docker run -itd --name api-server -p 127.0.0.1:811:80 nenew/openai-api
```
你的openai反代地址: http://127.0.0.1:811  
通过绑定到本地端口，可以阻止服务器被公众访问。  
如果想让你的api反代服务器被公开，你也可以通过-e选项来绑定一个可以访问的IP或者设置一个密码来保证只有自己可以使用。
```bash
docker run -itd --name api-server -p 811:80 -e BIND_IP="123.123.123.123" nenew/openai-api
docker run -itd --name api-server -p 811:80 -e SECRET="Your secret" nenew/openai-api
```
注意:如果你设置了SECRET环境变量,你还需要设置你的app的请求头，增加X-Secret来完成验证:
```html
X-Secret:Your secret
```
# 测试:
访问 http://127.0.0.1/status 你可以看到你的请求头、请求体、设置的IP、设置的密码以及响应头的具体信息.  
你也可以设置你的app的api到这个页面来进行测试或者使用Nginx的proxy_pass来设置转发。
```html
proxy_pass http://1277.0.0.1/status

```
# 为什么你的反代不安全
其实写这个docker的原因很简单，看到很多不安全因素存在在你们的自建api里面。  
首先你们没有去掉或者掩盖["X-Real-IP"]和["X-Forwarded-For"]。  
反向代理的作用是保护目标服务器，但是我们其实想通过反代保护我们自己来保障我们的app可以正常的访问，所以完全没有必要把我们的X-Real-IP和X-Forwarded-For给目标服务器。我们建立反代其实目的是建立一个正向代理。这两个参数明显会暴露我们自己的真实IP，造成api的key多人使用的问题。  
其次，很多人自建的api谁都可以用，比如像那些利用serverless实现的反代，你的访问IP地址每次都可能变化，那样子你的api key很可能就被判定为滥用【remote_addr一直是变化的】。我这个docker可以通过设置绑定IP和SECRET来阻止外界访问。
我认为最安全的方案应该是：  
把这个docker放在你的独立服务器或者VPS上，你可以设置你的web app也在同一台服务器上，当然你也可以设置你的app来通过加密或者绑定IP的方式来达到隐藏自己的目的。