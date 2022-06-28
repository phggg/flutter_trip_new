## Flutter集成步骤 (https://coding.imooc.com/learn/questiondetail/150166.html)
### 创建Flutter module
```bash
# 进入 native 项目的上一级目录 例：```xxx/hybrid/Native
# cd xxx/hybrid
# flutter create -t module -flutter_module
```
### 在原生项目中添加 Flutter module 依赖
#### android
1. 修改项目下的settings.gradle
2. 修改android的最低sdk版本为16，因为flutter最低只能支持到16
3. 在dependencies中添加flutter依赖
### 在 java/Object-c 中调用 Flutter module
#### android
1. java中调用flutter模块有两种方式
- Flutter.createView
- FlutterFragment
### 编写 dart 代码
### 运行项目
### 在混合开发里进行 flutter 的热重启/热加载
### 调试 dart 代码
### 发布应用