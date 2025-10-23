# ModifyCopilot
由于总所周知的原因copilot键基本弃用，此方案使用<a href="https://www.autohotkey.com/">autohotkey</a>和网页版豆包实现一键呼出ai
- 安装autohotkey（默认路径避免报错）
- 获取并打开CopilotOpenDoubao.ahk
- 设置CopilotOpenDoubao.ahk自启动
## 注意
- CopilotOpenDoubao.ahk中chrome的路径为默认，配置参数可修改
- 利用「启动」文件夹设置自启动最简单（Win+R输入shell:common startup将需要自启动的文件/快捷方式复制到该文件夹中，建议创建快捷方式后放入）
## BUG日志
1.0.0
1. 多窗口情况下查找页面逻辑漏洞导致无法直接调取已经打开的chat页
2. 特定网页无法正常调取chat页
3. 频繁点击copilot键会出现优先级问题
