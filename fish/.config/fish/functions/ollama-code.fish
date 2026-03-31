function ollama-code --description "Start Ollama with qwen2.5-coder:1.5b for nvim completions"
    if pgrep -x ollama > /dev/null
        echo "Ollama already running"
        return 0
    end
    OLLAMA_NUM_GPU=1 nohup ollama serve > /tmp/ollama.log 2>&1 &
    echo "Waiting for Ollama to start..."
    for i in (seq 1 10)
        if curl -s http://localhost:11434 > /dev/null 2>&1
            break
        end
        sleep 0.5
    end
    ollama run qwen2.5-coder:1.5b --keepalive 60m > /dev/null 2>&1 &
    echo "Ollama ready with qwen2.5-coder:1.5b"
end
