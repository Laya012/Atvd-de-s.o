cat > analisar_desempenho.sh << 'FIM'
#!/bin/bash

# ==============================================
# SCRIPT: analisar_desempenho.sh
# FUNÇÃO: Analisar desempenho do sistema
# ==============================================

echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║              ANÁLISE DE DESEMPENHO DO SISTEMA                 ║"
echo "╚═══════════════════════════════════════════════════════════════╝"

# Função para verificar processos com alto consumo
analisar_alto_consumo() {
    echo ""
    echo "🔍 PROCESSOS COM ALTO CONSUMO:"
    echo "═══════════════════════════════════════════════════════════════"
    
    echo ""
    echo "🔥 ALTO CONSUMO DE CPU (>50%):"
    echo "─────────────────────────────────────────────────────────────"
    ps aux | awk '$3 > 50 {print "   PID: " $2 " | CPU: " $3 "% | MEM: " $4 "% | CMD: " $11}'
    
    echo ""
    echo "📈 ALTO CONSUMO DE MEMÓRIA (>20%):"
    echo "─────────────────────────────────────────────────────────────"
    ps aux | awk '$4 > 20 {print "   PID: " $2 " | CPU: " $3 "% | MEM: " $4 "% | CMD: " $11}'
}

# Função para verificar processos comuns
analisar_processos_comuns() {
    echo ""
    echo "📊 ANÁLISE DE PROCESSOS ESPECÍFICOS:"
    echo "═══════════════════════════════════════════════════════════════"
    
    # Navegadores
    echo ""
    echo "🌐 NAVEGADORES:"
    firefox_count=$(pgrep -c firefox 2>/dev/null || echo 0)
    chrome_count=$(pgrep -c chrome 2>/dev/null || echo 0)
    echo "   Firefox: $firefox_count processo(s)"
    echo "   Chrome: $chrome_count processo(s)"
    
    # Serviços comuns
    echo ""
    echo "⚙️ SERVIÇOS COMUNS:"
    for servico in sshd cron cups bluetooth; do
        if pgrep -x $servico > /dev/null; then
            echo "   ✅ $servico está rodando"
        else
            echo "   ❌ $servico não está rodando"
        fi
    done
    
    # Shells ativos
    echo ""
    echo "🐚 SHELLS ATIVOS:"
    who | awk '{print "   " $1 " - " $5}'
}

# Função para recomendações
recomendacoes() {
    echo ""
    echo "💡 RECOMENDAÇÕES DE OTIMIZAÇÃO:"
    echo "═══════════════════════════════════════════════════════════════"
    
    # Verificar uso de memória
    mem_total=$(free | grep Mem | awk '{print $2}')
    mem_livre=$(free | grep Mem | awk '{print $4}')
    mem_percent=$(( (mem_total - mem_livre) * 100 / mem_total ))
    
    if [ $mem_percent -gt 90 ]; then
        echo "   ⚠️ Memória muito alta ($mem_percent%). Considere fechar aplicações pesadas."
    elif [ $mem_percent -gt 70 ]; then
        echo "   ⚠️ Memória moderada ($mem_percent%). Monitore processos."
    else
        echo "   ✅ Uso de memória ok ($mem_percent%)."
    fi
    
    # Verificar processos duplicados
    echo ""
    echo "   🔍 Processos duplicados:"
    ps aux | awk '{print $11}' | sort | uniq -c | sort -rn | head -5 | while read count cmd; do
        if [ $count -gt 3 ]; then
            echo "      - $cmd: $count instâncias"
        fi
    done
}

# Verificar processos zombie
verificar_zombie() {
    zombie_count=$(ps aux | awk '$8=="Z"' | wc -l)
    echo ""
    echo "🧟 PROCESSOS ZOMBIE:"
    echo "═══════════════════════════════════════════════════════════════"
    if [ $zombie_count -eq 0 ]; then
        echo "   ✅ Nenhum processo zombie encontrado!"
    else
        echo "   ⚠️ $zombie_count processo(s) zombie encontrado(s):"
        ps aux | awk '$8=="Z" {print "      - PID " $2 ": " $11}'
        echo ""
        echo "   Para matar processos zombie, o processo pai precisa ser finalizado:"
        echo "   kill -9 <PID_PAI>"
    fi
}

# Executar análises
analisar_alto_consumo
analisar_processos_comuns
verificar_zombie
recomendacoes

echo ""
echo "═══════════════════════════════════════════════════════════════"
echo "✅ Análise concluída!"
FIM

chmod +x analisar_desempenho.sh
