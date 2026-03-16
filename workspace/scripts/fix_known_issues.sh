#!/bin/bash
# fix_known_issues.sh — 自动修复已知问题
# 创建时间：2026-03-16
# 用途：每次启动时自动检查并修复已知问题

set -e
WORKSPACE="/home/gem/workspace/agent/workspace"
EVOLVER="/home/gem/workspace/agent/skills/evolver"

echo "🔧 检查已知问题..."

# 问题1: self_check.py 路径失效
echo "[1] 检查 self_check.py..."
SELF_CHECK=$(find $WORKSPACE -name "self_check.py" 2>/dev/null | head -1)
if [ -z "$SELF_CHECK" ]; then
    echo "  ❌ self_check.py 不存在，创建替代版本..."
    cat > $WORKSPACE/scripts/self_check_lite.sh << 'SELFCHECK'
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
SELFCHECK
    chmod +x $WORKSPACE/scripts/self_check_lite.sh
    echo "  ✅ 已创建 self_check_lite.sh"
else
    echo "  ✅ self_check.py 存在: $SELF_CHECK"
fi

# 问题2: validate-modules.js 缺失导致 evolver solidify 失败
echo "[2] 检查 validate-modules.js..."
if [ ! -f "$EVOLVER/scripts/validate-modules.js" ]; then
    echo "  ❌ validate-modules.js 不存在，创建..."
    mkdir -p $EVOLVER/scripts
    cat > $EVOLVER/scripts/validate-modules.js << 'VALIDATE'
#!/usr/bin/env node
// validate-modules.js — 验证模块是否可加载
const modules = process.argv.slice(2);
let ok = true;
for (const mod of modules) {
    try {
        require(mod.startsWith('./') ? require('path').resolve(mod) : mod);
        console.log(`✅ ${mod}`);
    } catch(e) {
        console.error(`❌ ${mod}: ${e.message}`);
        ok = false;
    }
}
process.exit(ok ? 0 : 1);
VALIDATE
    chmod +x $EVOLVER/scripts/validate-modules.js
    echo "  ✅ 已创建 validate-modules.js"
else
    echo "  ✅ validate-modules.js 已存在"
fi

# 问题3: 检查 evolver pid 文件是否过期
echo "[3] 检查 evolver PID 文件..."
if [ -f "$EVOLVER/evolver.pid" ]; then
    PID=$(cat "$EVOLVER/evolver.pid")
    if ! kill -0 "$PID" 2>/dev/null; then
        echo "  ⚠️  PID $PID 已过期，清理..."
        rm -f "$EVOLVER/evolver.pid"
        echo "  ✅ 已清理过期 PID"
    else
        echo "  ✅ PID $PID 有效"
    fi
fi

# 问题4: 检查 memory 目录
echo "[4] 检查 memory 目录..."
mkdir -p $WORKSPACE/memory
TODAY=$(date +%Y-%m-%d)
if [ ! -f "$WORKSPACE/memory/$TODAY.md" ]; then
    echo "# $TODAY 自主进化记录" > "$WORKSPACE/memory/$TODAY.md"
    echo "  ✅ 已创建今日日志"
else
    echo "  ✅ 今日日志存在"
fi

echo ""
echo "🏁 检查完成！"
