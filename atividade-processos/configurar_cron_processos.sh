cat > configurar_cron_processos.sh << 'FIM'
#!/bin/bash

# ==============================================
# SCRIPT: configurar_cron_processos.sh
# FUNÇÃO: Configurar agendamentos de monitoramento
# ==============================================

SCRIPT_DIR=$(realpath $(dirname $0))

echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║         CONFIGURAR AGENDAMENTOS DE MONITORAMENTO              ║"
echo "╚═══════════════════════════════════════════════════════════════╝"

# Backup do crontab
crontab -l > /tmp/crontab_backup_$(date '+%Y%m%d_%H%M%S').txt 2>/dev/null
echo "✅ Backup do crontab salvo"

# Remover configurações antigas
crontab -l 2>/dev/null | grep -v "monitorar_recursos.sh" | crontab - 2>/dev/null

# Adicionar novas configurações
(
    echo "# ================================================"
    echo "# AGENDAMENTOS DE MONITORAMENTO DE PROCESSOS"
    echo "# INSTALADO EM: $(date '+%d/%m/%Y %H:%M:%S')"
    echo "# ================================================"
    echo ""
    
    # A cada 5 minutos - monitorar recursos
    echo "# Monitorar recursos a cada 5 minutos"
    echo "*/5 * * * * $SCRIPT_DIR/monitorar_recursos.sh"
    echo ""
    
    # A cada hora - verificar processos zombie
    echo "# Verificar processos zombie a cada hora"
    echo "0 * * * * ps aux | awk '\$8==\"Z\"' | wc -l >> $HOME/zombie_count.log"
    echo ""
    
    # Diariamente às 8h - análise de desempenho
    echo "# Análise de desempenho diária"
    echo "0 8 * * * $SCRIPT_DIR/analisar_desempenho.sh >> $HOME/analise_diaria.log"
    
) | crontab -

echo ""
echo "✅ TAREFAS AGENDADAS:"
echo "═══════════════════════════════════════════════════════════════"
crontab -l
echo "═══════════════════════════════════════════════════════════════"

echo ""
echo "📋 RESUMO:"
echo "   • Monitoramento de recursos: a cada 5 minutos"
echo "   • Verificação de processos zombie: a cada hora"
echo "   • Análise de desempenho: diariamente às 8h"
echo ""
echo "📁 Logs salvos em: $HOME/monitoramento_logs/"
echo "🔧 Para remover: crontab -r"
FIM

chmod +x configurar_cron_processos.sh
