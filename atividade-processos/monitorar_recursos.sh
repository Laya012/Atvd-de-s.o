#!/bin/bash

# ==============================================
# SCRIPT: monitorar_recursos.sh
# FUNÇÃO: Monitorar recursos do sistema
# ==============================================

DATA=$(date '+%d/%m/%Y %H:%M:%S')
LOG_DIR="$HOME/monitoramento_logs"
mkdir -p $LOG_DIR

LOG_FILE="$LOG_DIR/monitoramento_$(date '+%Y%m%d_%H%M%S').log"

echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║              MONITORAMENTO DE RECURSOS DO SISTEMA             ║"
echo "╚═══════════════════════════════════════════════════════════════╝"

monitorar() {
    echo ""
    echo "📊 RELATÓRIO DE MONITORAMENTO - $DATA"
    echo "═══════════════════════════════════════════════════════════════"
    
    echo ""
    echo "🖥️  INFORMAÇÕES DO SISTEMA:"
    echo "─────────────────────────────────────────────────────────────"
    echo "   Hostname: $(hostname)"
    echo "   Usuário: $(whoami)"
    echo "   Data/Hora: $DATA"
    echo "   Sistema: $(uname -a)"
    echo "   Uptime: $(uptime -p)"
    
    echo ""
    echo "💾 MEMÓRIA RAM:"
    echo "─────────────────────────────────────────────────────────────"
    free -h
    
    echo ""
    echo "⚡ CARGA DA CPU:"
    echo "─────────────────────────────────────────────────────────────"
    top -bn1 | head -5
    
    echo ""
    echo "💿 ESPAÇO EM DISCO:"
    echo "─────────────────────────────────────────────────────────────"
    df -h | grep -E "^/dev/"
    
    echo ""
    echo "🔥 TOP 5 PROCESSOS (CPU):"
    echo "─────────────────────────────────────────────────────────────"
    ps aux --sort=-%cpu | head -6 | tail -5
    
    echo ""
    echo "📈 TOP 5 PROCESSOS (MEMÓRIA):"
    echo "─────────────────────────────────────────────────────────────"
    ps aux --sort=-%mem | head -6 | tail -5
    
    echo ""
    echo "🌐 CONEXÕES DE REDE:"
    echo "─────────────────────────────────────────────────────────────"
    netstat -tunap 2>/dev/null | head -10 || ss -tunap | head -10
    
    echo ""
    echo "🧟 PROCESSOS ZOMBIE:"
    echo "─────────────────────────────────────────────────────────────"
    ps aux | awk '$8=="Z" {print}' | wc -l | xargs echo "   Total de processos zombie:"
    ps aux | awk '$8=="Z" {print "   PID " $2 ": " $11}'
    
    echo ""
    echo "═══════════════════════════════════════════════════════════════"
}

monitorar | tee -a $LOG_FILE

echo ""
echo "✅ Relatório salvo em: $LOG_FILE"
echo "📊 Total de processos: $(ps aux | wc -l)"
