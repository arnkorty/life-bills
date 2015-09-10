# Life Bills 
生活账单管理系统，管理你的生活


## 系统要求
* Ruby 2.0.0 (or 1.9.3)
* MongoDB
* Redis

## 微信端配置

**微信url：** http://你的域名/weixin

**微信token：**
```yaml
# config/application.yml
weixin_token: 你的token
```
## 安装
```bash
git clone git://github.com/arnkorty/life-bills
cd life-bills
cp config/mongoid.yml.default config/mongoid.yml
cp config/application.yml.default config/application.yml
bundle install
rails s
```
## License

[The MIT License](https://github.com/19wu/19wu/blob/master/LICENSE)
