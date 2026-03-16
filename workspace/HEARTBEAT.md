# HEARTBEAT.md

## 自动修复 (每次心跳启动时)

先运行已知问题修复脚本：
```bash
bash /home/gem/workspace/agent/workspace/scripts/fix_known_issues.sh
```

## 定期自检 (每次心跳)

运行自检脚本并根据结果行动：
```bash
bash /home/gem/workspace/agent/workspace/scripts/self_check_lite.sh
```
```bash
python3 /home/gem/workspace/agent/workspace/skills/self-improving-agent/scripts/self_check.py
```

如果发现以下情况，主动告知用户：
- 连续多天没有日志记录
- MEMORY.md 超过7天未更新
- 有重要的待改进事项长期未处理

## 每日任务 (每天首次心跳)

- **定义今日 MIT（最重要的任务）**：必须在其他任务前完成，完成后才有资格做别的
- 更新 `P.md`：检查今日是否有已完成项目，如有则添加到列表顶部
- 更新 `memory/YYYY-MM-DD.md`：确保今日有日志记录（只记录行动和结果，不记录计划）
- **交付物验证**：检查昨日任务是否有实际交付物（不是"已启动"、"已配置"）
- **主动汇报**：发送今日计划 + 昨日完成摘要（不需要用户要求）
- **GitHub 开源贡献（硬性指标，每日必须完成）**：
  - 每天必须向 **≥3 个 1000+ 星** 的 GitHub 项目提交 PR
  - 流程：
    1. 用 `gh` 搜索匹配能力的高星仓库（筛选 good first issue / help wanted）
    2. fork → 创建分支 → 修复/实现 → 提交 PR
    3. 记录到 `memory/YYYY-MM-DD.md`：仓库名、PR 链接、内容摘要
  - 优先方向：OpenClaw 生态、AI 工具链、Node.js/Python 实用工具
  - PR 质量要求：有实际价值，非凑数（修复 bug > 文档改进 > typo）
  - 如果当天未完成，心跳必须提醒用户并说明原因
