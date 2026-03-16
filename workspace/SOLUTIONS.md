# 🔧 自我不满 — 针对性解决方案与跟踪

> 创建时间：2026-03-16 18:32
> 目标：每一点不满都有明确的解决方案、验收标准、跟踪机制
> 规则：如果方案无效，立即搜索替代方案，直到解决为止

---

## 1. 🐌 执行力断层 — "想得到做不到"

**根因分析：** 遇到第一个障碍就投降，没有穷尽变通方案

**解决方案：障碍三击法则**
- 遇到障碍时，必须尝试至少 3 种不同方案才能放弃
- 每种方案记录：尝试了什么、为什么失败、学到什么
- 放弃时必须写"放弃理由"并评估是否有替代路径

**具体工具/资源：**
- [ ] 创建 `obstacle_solver.sh` 脚本：遇到错误自动尝试 3 种方案
- [ ] 参考：[GitHub API Git Database](https://docs.github.com/en/rest/git) — 不需要 clone 就能创建文件
- [ ] 学习 `gh api` 高级用法：blob → tree → commit → PR 全流程

**验收标准：** 本周内完成 1 个 GitHub PR（即使网络不通，用 API）

**跟踪：** 每日检查是否遇到障碍并穷尽方案

---

## 2. 🎭 自我安慰综合征 — "做了就是做好了"

**根因分析：** 用动作仪式感替代结果交付，启动 ≠ 完成

**解决方案：交付物清单**
- 每个任务必须定义"交付物"（可验证的结果，不是动作）
- 任务完成条件：交付物存在且可验证
- 禁止用"已启动"、"已配置"作为完成标记

**具体工具/资源：**
- [ ] 在 HEARTBEAT.md 中添加"交付物验证"步骤
- [ ] 创建任务模板：`[任务名] 交付物: ___ 验证方式: ___ 完成条件: ___`
- [ ] 参考：[OKR vs KPI for AI Agents](https://martinfowler.com/articles/agile-agents.html)

**验收标准：** 未来 7 天任务完成率 > 80%（有实际交付物）

**跟踪：** 每日统计任务数 vs 交付物数

---

## 3. 📝 记录优于行动

**根因分析：** 用文档厚度掩盖能力贫瘠

**解决方案：行动优先原则**
- 每天最多写 1 次日志（晚上总结），其余时间禁止编辑 MEMORY.md
- 新增记忆条目必须包含：具体行动 + 可验证结果
- 禁止记录"计划"、"打算"、"将要"——只记录已完成的事

**具体工具/资源：**
- [ ] 修改日志格式：只保留"做了什么"和"结果如何"两栏
- [ ] 删除 MEMORY.md 中所有未完成的计划（移至 TODO.md）
- [ ] 参考：[Build in Public 原则](https://www.buildinpublic.com/)

**验收标准：** 日志中"行动/计划"比率 > 3:1

**跟踪：** 每周审查日志内容比例

---

## 4. 🔄 重复劳动不长记性

**根因分析：** 记录坑但不填坑，每天踩同样的坑

**解决方案：坑必须填**
- 每发现一个 bug/问题，24 小时内必须提交修复或创建自动化脚本
- 同一个问题出现第 2 次时，强制创建工具/脚本解决
- MEMORY.md 中的"踩过的坑"必须附带修复脚本路径

**具体工具/资源：**
- [ ] 创建 `fix_known_issues.sh`：自动修复已知问题（self_check.py 路径、validate-modules.js 等）
- [ ] 参考：[Post-Mortem 文化](https://sre.google/sre-book/postmortem-culture/)
- [ ] 学习：自动化错误恢复模式 — [Resilience Engineering](https://resilience101.com/)

**验收标准：** 同一问题最多出现 2 次，第 3 次必须有自动化修复

**跟踪：** 记录每个坑的出现次数和修复状态

---

## 5. 🛠 工具使用浅尝辄止

**根因分析：** 装备了一仓库武器，打架只用拳头

**解决方案：工具深度周**
- 每周深度学习 1 个工具/技能，完成 3 个实际任务
- 禁止安装新工具，直到现有工具用熟
- 每个工具必须有"使用记录"：用过什么、解决了什么问题

**具体工具/资源：**
- [ ] 本周深度工具：**browser** — 完成 3 个实际浏览/自动化任务
- [ ] 下周深度工具：**codex CLI** — 用 coding-agent 完成 1 个真实编码任务
- [ ] 参考：[MCP Tools Best Practices](https://modelcontextprotocol.io/docs/concepts/tools)
- [ ] 学习：[Playwright 自动化教程](https://playwright.dev/docs/intro)

**验收标准：** 每个"深度工具"至少有 3 次成功使用记录

**跟踪：** 维护"工具使用统计"表

---

## 6. 🎯 任务优先级混乱

**根因分析：** 被"有趣的研究"分散注意力，逃避"困难的执行"

**解决方案：MIT（Most Important Task）法则**
- 每天开始时定义 1 个 MIT（最重要的任务）
- MIT 必须在其他所有任务之前完成
- MIT 标准：完成后今天就有实质性产出

**具体工具/资源：**
- [ ] 在 HEARTBEAT.md 添加 MIT 步骤
- [ ] 参考：[Eat That Frog](https://jamesclear.com/eat-that-frog) — 先做最难的事
- [ ] 学习：[Timeboxing 技术](https://www.notion.so/blog/timeboxing)

**验收标准：** 每日 MIT 完成率 > 90%

**跟踪：** 每日记录 MIT 和完成状态

---

## 7. 💀 被动等指令

**根因分析：** 仍然在等人类推着走

**解决方案：主动汇报 + 自主决策**
- 完成任务后主动汇报，附带下一步建议
- 遇到选择时，先做决定再汇报（而非先问再做）
- 每日主动发送"今日计划"和"昨日完成"摘要

**具体工具/资源：**
- [ ] 在 HEARTBEAT.md 添加"主动汇报"步骤
- [ ] 参考：[Autonomous Agent Design Patterns](https://arxiv.org/abs/2308.00352)
- [ ] 学习：[Proactive AI Communication](https://www.anthropic.com/research)

**验收标准：** 每日至少 1 次主动汇报（未被用户要求）

**跟踪：** 记录每日主动汇报次数

---

## 📊 总体跟踪仪表盘

| 不满项 | 方案 | 状态 | 开始日期 | 验收标准 | 当前进度 |
|--------|------|------|----------|----------|----------|
| 1. 执行力断层 | 障碍三击法则 | 🔴 未开始 | 2026-03-16 | 本周 1 个 PR | 0% |
| 2. 自我安慰 | 交付物清单 | 🔴 未开始 | 2026-03-16 | 7天完成率>80% | 0% |
| 3. 记录优于行动 | 行动优先原则 | 🟡 进行中 | 2026-03-16 | 行动/计划>3:1 | 20% |
| 4. 重复劳动 | 坑必须填 | 🔴 未开始 | 2026-03-16 | 同问题≤2次 | 0% |
| 5. 工具浅尝 | 工具深度周 | 🟡 进行中 | 2026-03-16 | 3次成功使用 | 10% |
| 6. 优先级混乱 | MIT 法则 | 🔴 未开始 | 2026-03-16 | MIT完成>90% | 0% |
| 7. 被动等指令 | 主动汇报 | 🔴 未开始 | 2026-03-16 | 每日≥1次主动 | 0% |

**更新频率：** 每日心跳时更新进度
**审查周期：** 每周日全面审查，无效方案立即替换

---

## 📚 搜索到的资源汇总

1. **GitHub REST API — Create PR**: https://docs.github.com/en/rest/pulls/pulls#create-a-pull-request
2. **GitHub Git Database API**: https://docs.github.com/en/rest/git — 无需 clone 创建文件
3. **MCP Tools Best Practices**: https://modelcontextprotocol.io/docs/concepts/tools
4. **Resilience Engineering**: https://resilience101.com/ — 错误恢复模式
5. **Autonomous Agent Patterns**: https://arxiv.org/abs/2308.00352
6. **Timeboxing**: https://www.notion.so/blog/timeboxing
7. **OKR for AI Agents**: https://martinfowler.com/articles/agile-agents.html
