#!/bin/sh
# Quick prompt to local LLM via Ollama
# Usage: ask <prompt>
#        cat file | ask "explain this"
#        OLLAMA_MODEL=dolphin3 ask "hello"

MODEL="${OLLAMA_MODEL:-qwen3:14b}"
OLLAMA="http://10.1.0.113:11434"

PROMPT="$*"
if [ -z "$PROMPT" ] && [ -t 0 ]; then
  echo "Usage: ask <prompt>"
  echo "       cat file | ask \"explain this\""
  echo "       OLLAMA_MODEL=dolphin3 ask \"hello\""
  exit 1
fi

# If stdin has data, prepend it as context
if [ ! -t 0 ]; then
  CONTEXT=$(cat)
  PROMPT="$(printf '%s\n\n%s' "$CONTEXT" "$PROMPT")"
fi

curl -sN "$OLLAMA/api/generate" \
  -d "$(jq -n --arg model "$MODEL" --arg prompt "$PROMPT" \
    '{model: $model, prompt: $prompt, stream: true}')" \
  | jq -rj '.response // empty'

echo ""
