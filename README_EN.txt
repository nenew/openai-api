[查看中文说明](https://github.com/nenew/openai-api/blob/main/README.md "查看中文说明")
# How to use:
```bash
docker pull nenew/openai-api
docker run -itd --name api-server -p 127.0.0.1:811:80 nenew/openai-api
```
your openai proxy address: http://127.0.0.1:811
This step can avoid your reverse proxy api server from public visit. 
If you want your api server to be public availiable.
You can use -e option to bind an IP or use a secret.
```bash
docker run -itd --name api-server -p 811:80 -e BIND_IP="123.123.123.123" nenew/openai-api
docker run -itd --name api-server -p 811:80 -e SECRET="Your secret" nenew/openai-api
```
Note:If you set a SECRET ,you should also set your request header with:
```html
X-Secret:Your secret
```
# How to test:
Visit http://127.0.0.1/status to see your request and response details.
It's designed for BIND_IP or SECRET test.
You could alse set your Nginx servser with 
```html
proxy_pass http://1277.0.0.1/status

```
to test your app to check if it work properly with this api reverse proxy server.