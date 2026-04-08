function claude-commit
    git diff --cached | claude --model haiku -p "Write a concise git commit message. Use this
    format: [feature|hotfix|refactor|chore]: [concise commit message]. Output only the message, nothing else."
end

