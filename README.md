# RubySdk
在 Rails 应用中以微服务形式集成 Work Design 的业务组件

## Usage
How to use my plugin.

```ruby
gem 'work_design', require: 'work_design'
```

## 如何使用

controller
```ruby
class ApplicationController < ActionController::API
  include WorkDesign::Proxy
  include WorkDesign::Identify
end
```

Routes
```ruby
Rails.application.routes.append do
  match 'wechat/*path' => 'home#wechat', via: :all
end
```


## 许可证
遵循 [MIT](https://opensource.org/licenses/MIT) 协议
