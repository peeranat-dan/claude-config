#!/bin/sh
input=$(cat)

context_window_size=$(echo "$input" | jq -r '.context_window.context_window_size // empty')
current_usage=$(echo "$input" | jq -r '.context_window.current_usage // empty')
model_name=$(echo "$input" | jq -r '.model.display_name // empty')

# ANSI colors
RED='\033[0;31m'
RESET='\033[0m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'

if [ -n "$current_usage" ] && [ -n "$context_window_size" ]; then
    used_tokens=$(echo "$input" | jq '
        (.context_window.current_usage.input_tokens // 0) +
        (.context_window.current_usage.output_tokens // 0) +
        (.context_window.current_usage.cache_creation_input_tokens // 0) +
        (.context_window.current_usage.cache_read_input_tokens // 0)
    ')

    percent=$(echo "scale=1; $used_tokens * 100 / $context_window_size" | bc)
else
    used=$(echo "$input" | jq -r '.context_window.used_percentage // 0')
    context_window_size=$(echo "$input" | jq -r '.context_window.context_window_size // 0')
    used_tokens=$(echo "scale=0; $used * $context_window_size / 100" | bc 2>/dev/null || echo "0")
    percent="$used"
fi

# Abbreviate tokens to k with 1 decimal (e.g. 96800 -> 96.8k)
abbrev=$(echo "scale=1; $used_tokens / 1000" | bc)

# if tokens is 0, show 0 instead of 0k
if [ "$used_tokens" -eq 0 ]; then
    display="No usage (0%)"
else
    display="${abbrev}k (${percent}%)"
fi

# add model name if exists
if [ -n "$model_name" ]; then
    display="$display - $model_name"
fi

if [ "$(echo "$used_tokens > 100000" | bc)" = "1" ]; then
    printf "${RED}%s 🔥${RESET}" "$display"
elif [ "$(echo "$used_tokens > 80000" | bc)" = "1" ]; then
    printf "${RED}%s${RESET}" "$display"
elif [ "$(echo "$used_tokens > 50000" | bc)" = "1" ]; then
    printf "${YELLOW}%s${RESET}" "$display"
else
    printf "${GREEN}%s${RESET}" "$display"
fi