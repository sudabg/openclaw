---
name: feishu-skill-architect
version: 1.0.0
description: "飞书三层 skill 架构：Service/Persona/Recipe，仿照 googleworkspace/cli 设计。"
metadata:
  openclaw:
    category: "productivity"
    requires:
      bins: ["gws"]  # 参考实现
---

# 飞书三层 Skill 架构

> **灵感来源**: googleworkspace/cli 的 Service/Persona/Recipe 三层架构  
> **适用场景**: 当你需要为飞书 API 构建标准化、可组合的 skill 时

## 核心理念

将飞书能力按抽象层次组织：

| 层级 | 前缀 | 职责 | 示例 |
|------|------|------|------|
| **Service** | `feishu-<service>` | 单个 API 操作 | `feishu-im`, `feishu-calendar`, `feishu-doc` |
| **Persona** | `persona-<role>` | 聚合多服务为角色 | `persona-feishu-assistant`, `persona-feishu-project-manager` |
| **Recipe** | `recipe-<workflow>` | 多步骤任务流程 | `recipe-feishu-meeting-notes`, `recipe-feishu-daily-standup` |

每个层级通过 `SKILL.md` 定义，采用统一的 YAML frontmatter + 结构化文档格式。

---

## 🏗️ 如何使用这个架构

### 1. 定义 Service Skill（基础操作）

每个 Service 对应飞书的一个服务模块（im、calendar、doc 等），提供该模块的基础命令。

**示例**: `feishu-im/SKILL.md`
```markdown
---
name: feishu-im
version: 1.0.0
description: "飞书即时消息: 发送、接收、搜索消息，管理图片和文件资源。"
metadata:
  openclaw:
    category: "productivity"
    requires:
      bins: ["feishu"]
    cliHelp: "im --help"
---

# feishu-im

## 命令

| 命令 | 说明 |
|------|------|
| `message send` | 发送消息 |
| `message react` | 添加表情反应 |
| `im_user_get_messages` | 获取历史消息 |
| ... | ... |

## 示例

```bash
message send --target "user:ou_xxx" --message "你好"
```
```

### 2. 定义 Persona Skill（角色能力）

Persona 将多个 Service 组合成一个角色（如执行助理、项目经理），声明其所需的 Service 列表。

**示例**: `persona-feishu-assistant/SKILL.md`
```markdown
---
name: persona-feishu-assistant
version: 1.0.0
description: "飞书全能助理: 管理消息、日程、文档、任务的综合角色。"
metadata:
  openclaw:
    category: "persona"
    requires:
      bins: ["feishu"]
      skills: ["feishu-im", "feishu-calendar", "feishu-doc", "feishu-task"]
---

# Feishu Assistant

> **前置条件**: 加载以下技能: `feishu-im, feishu-calendar, feishu-doc, feishu-task`

飞书全能助理: 管理消息、日程、文档、任务的综合角色。

## 相关工作流
- `每日早报: 查询今日日程 + 待办任务 + 未读消息`
- `会议纪要: 记录会议内容 → 创建文档 → 发送到群`

## 指导原则
- 开始任务前先检查日历和待办
- 保持沟通简洁专业
- 重要操作先确认再执行
```

### 3. 定义 Recipe Skill（工作流流程）

Recipe 描述一个多步骤的业务流程，给出每一步的可执行 CLI 示例。

**示例**: `recipe-feishu-meeting-notes/SKILL.md`
```markdown
---
name: recipe-feishu-meeting-notes
version: 1.0.0
description: "会议结束后自动创建纪要文档并发送到相关群组。"
metadata:
  openclaw:
    category: "recipe"
    domain: "productivity"
    requires:
      bins: ["feishu"]
      skills: ["feishu-calendar", "feishu-doc", "feishu-im"]
---

# 飞书会议纪要自动创建

> **前置条件**: 加载以下技能: `feishu-calendar, feishu-doc, feishu-im`

会议结束后自动创建纪要文档并发送到相关群组。

## 步骤

1. 查询刚结束的日程: `calendar_event list` 查找 end_time 在过去 1 小时内的日程
2. 获取参会人列表: `calendar_event_attendee list --event_id <ID>`
3. 创建纪要文档: `feishu_create_doc --title '<日程标题> 纪要' --markdown '...'`
4. 发送到群聊: `message send --target 'chat:<群ID>' --message '会议纪要已创建: <文档链接>'`

## 注意
- 确认参数正确后再执行
- 记录操作结果
```

---

## 🔧 技能生成器（可选工具）

为了快速生成符合此架构的 skill，可以使用 `skill-gen.py`（见 `skills/feishu-workspace/skill-gen.py`）：

```bash
# 生成所有示例 skill
python3 skill-gen.py --all --output ./generated

# 只生成 service
python3 skill-gen.py --service feishu-im --output ./my-skills

# 只生成 persona
python3 skill-gen.py --persona --output ./my-skills

# 只生成 recipe
python3 skill-gen.py --recipe --output ./my-skills
```

生成器会为每个 skill 创建标准的 `SKILL.md` 文件。

---

## 📚 现有可用技能（示例）

在 `skills/feishu-workspace/generated/` 目录下可以看到完整示例：

### Service Skills
- `feishu-im` — 消息收发、搜索、资源下载
- `feishu-calendar` — 日程、参会人、忙闲查询
- `feishu-doc` — 文档创建/获取/更新/搜索
- `feishu-bitable` — 多维表格 App/表/字段/记录
- `feishu-task` — 任务和清单管理
- `feishu-chat` — 群聊搜索、信息、成员

### Persona Skills
- `persona-feishu-assistant` — im + calendar + doc + task
- `persona-feishu-project-manager` — bitable + task + chat + im
- `persona-feishu-exec` — calendar + im + doc + chat

### Recipe Skills
- `recipe-feishu-meeting-notes` — 会议纪要自动创建 → 发群
- `recipe-feishu-daily-standup` — 多维表格 → 站会报告 → 发群
- `recipe-feishu-weekly-report` — 任务汇总 → 周报文档
- `recipe-feishu-onboarding` — 新成员检测 → 欢迎 → 入职文档
- `recipe-feishu-form-to-bitable` — 表单回复 → 多维表格同步
- `recipe-feishu-smart-reminder` — 日程+任务 → 智能提醒

---

## ✅ 迁移现有 Skill 的建议

如果你已有传统的飞书 skill（如 `feishu-im-read`），可以考虑：

1. **拆分为 Service**：将原有 skill 的核心能力抽取为 Service（如 `feishu-im` 覆盖 im 的基本操作）
2. **保留或迁移为 Recipe**：如果原有 skill 描述了一个多步骤流程（如“获取消息并下载附件”），可改写为 Recipe
3. **定义 Persona**：根据团队角色，将相关 Service 组合为 Persona skill
4. **统一前置条件**：在每个 skill 中声明 `requires: skills: [...]`，使依赖关系可见

---

## 🎯 优势总结

| 改进点 | 说明 |
|--------|------|
| **结构清晰** | 从平铺功能包 → 三层体系，匹配用户心智模型 |
| **文档统一** | 每个 skill 有相同的 YAML + 章节结构，减少认知负荷 |
| **前置即可用** | `cliHelp`、`示例` 直接给出可运行命令，零搜索成本 |
| **可自动生成** | 新服务只需编义务描述，技能生成器自动输出完整 skill |
| **链式引用** | 共享参考文档统一认证/全局旗标/安全规则，避免重复 |
| **可索引注册表** | 自动生成的 `registry.yaml` 支持程序化发现所有 recipe |

> 使用这个架构，你可以像使用积木一样组装飞书能力：先选 Service（基础操作），再组合 Persona（角色能力），最后编排 Recipe（工作流自动化）。

---
*注: 此 skill 本身说明了架构，不直接提供飞书 API 调用。实际操作请参考生成的 service/persona/recipe skill，或使用 skill-gen.py 生成自己的。*