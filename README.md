# ModifyCopilot
由于总所周知的原因copilot键基本弃用，此方案使用<a href="https://www.autohotkey.com/">autohotkey</a>和网页版豆包实现一键呼出ai
- 安装autohotkey（默认路径避免报错）
- 获取并打开CopilotOpenDoubao.ahk
## 注意
CopilotOpenDoubao.ahk中chrome的路径为默认，配置参数可修改
### BuG日志
1.0.0
多窗口情况下查找页面逻辑漏洞导致无法直接调取已经打开的chat页
特定网页无法正常调取chat页
