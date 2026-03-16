# TOOLS.md - 环境笔记

## 运行环境

- **主机**: Miaoda Cloud Computer（妙搭云电脑）
- **OS**: Linux 5.15.120 (x64)
- **Node**: v22.21.0
- **Python**: python3
- **浏览器**: Chromium headless (`/usr/bin/chromium-browser`)
- **不支持 systemd** — gateway 用 `sh scripts/restart.sh`

## 工作区路径

- **Workspace**: `/home/gem/workspace/agent/workspace`
- **Memory 日志**: `/home/gem/workspace/agent/workspace/memory/`
- **扩展插件**: `/home/gem/workspace/agent/extensions/`
- **飞书技能**: `/home/gem/workspace/agent/extensions/feishu-openclaw-plugin/skills/`

## 常用命令

```bash
# 自我检查
python3 /home/gem/workspace/agent/workspace/skills/self-improving-agent/scripts/self_check.py

# 经验提取
python3 /home/gem/workspace/agent/workspace/skills/self-improving-agent/scripts/extract_lessons.py

# Gateway 管理（无 systemd）
sh /home/gem/workspace/agent/scripts/restart.sh
sh /home/gem/workspace/agent/scripts/start.sh
sh /home/gem/workspace/agent/scripts/stop.sh
```

## 模型配置

| 模型 | 用途 | 特点 |
|------|------|------|
| openrouter/hunter-alpha | 主模型 | 推理能力强，100万上下文 |
| miaoda-auto-multimodal | 图片分析 | 多模态 |
| miaoda-model-auto | 备用 | 免费 |

## 飞书应用

- **App ID**: cli_a9389f371a7a9bc2
- **域**: feishu
- **DM 白名单**: ou_6578be82850c77fb62a767b5441a065f

## 技能位置

- 工作区技能: `workspace/skills/`（1个: self-improving-agent）
- 飞书技能: `extensions/feishu-openclaw-plugin/skills/`（9个）
- 内置技能: `/usr/lib/node_modules/openclaw/skills/`（43个）

---
*最后更新: 2026-03-13 07:57*
