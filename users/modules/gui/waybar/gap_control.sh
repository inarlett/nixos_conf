# 一个临时变量位置，记录当前 gaps 值（避免用 hyprctl getoption）
STATE_FILE="/run/user/$UID/gap_value"
DEFAULT_GAP=10

# 读取旧值
if [[ -f "$STATE_FILE" ]]; then
    GAP=$(cat "$STATE_FILE")
else
    GAP=$DEFAULT_GAP
fi

# 根据滚轮操作调整
case $1 in
    scroll-up)
        GAP=$((GAP + 2))
        ;;
    scroll-down)
        GAP=$((GAP - 2))
        ;;
esac

# 限制范围
if (( GAP < 0 )); then GAP=0; fi

# 应用到 Hyprland
hyprctl --batch "keyword general:gaps_in $GAP; keyword general:gaps_out $GAP"

# 保存新值
echo "$GAP" > "$STATE_FILE"

# 输出给 Waybar 显示
echo "{\"text\": \"Gaps: $GAP\"}"

