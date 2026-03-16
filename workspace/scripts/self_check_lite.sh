#!/bin/bash
# self_check_lite — 简化版自检脚本
echo "🦞 XiXi 自检 - $(date +%Y-%m-%d)"
echo "=================================================="
ERRORS=0

# 检查核心文件
for f in SOUL.md AGENTS.md MEMORY.md USER.md HEARTBEAT.md; do
    [ -f "/home/gem/workspace/agent/workspace/$f" ] && echo "✅ $f" || { echo "❌ $f 缺失"; ERRORS=$((ERRORS+1)); }
done

# 检查日志
TODAY=$(date +%Y-%m-%d)
[ -f "/home/gem/workspace/agent/workspace/memory/$TODAY.md" ] && echo "✅ 今日日志" || { echo "⚠️  今日日志缺失"; ERRORS=$((ERRORS+1)); }

# 检查 evolver
pgrep -f "index.js --loop" > /dev/null && echo "✅ Evolver 运行中" || { echo "⚠️  Evolver 未运行"; }

# 检查 gh 认证
gh auth status > /dev/null 2>&1 && echo "✅ GitHub 认证" || { echo "❌ GitHub 未认证"; ERRORS=$((ERRORS+1)); }

echo "=================================================="
echo "健康度: $((100 - ERRORS * 10))%"
