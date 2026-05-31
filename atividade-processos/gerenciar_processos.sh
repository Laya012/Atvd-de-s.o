#!/bin/bash

# ==============================================
# SCRIPT: gerenciar_processos.sh
# FUNÇÃO: Gerenciar processos do sistema
# ==============================================

echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║              GERENCIAMENTO DE PROCESSOS - LINUX               ║"
echo "╚═══════════════════════════════════════════════════════════════╝"

menu_principal() {
    echo ""
    echo "┌─────────────────────────────────────────────────────────────┐"
    echo "│                      MENU PRINCIPAL                         │"
    echo "├─────────────────────────────────────────────────────────────┤"
    echo "│  1 - Listar todos os processos                             │"
    echo "│  2 - Listar processos por usuário                          │"
    echo "│  3 - Listar top 10 processos (CPU)                         │"
    echo "│  4 - Listar top 10 processos (MEMÓRIA)                     │"
    echo "│  5 - Matar um processo                                     │"
    echo "│  6 - Pausar/Continuar um processo                          │"
    echo "│  7 - Ver árvore de processos                               │"
    echo "│  8 - Monitorar em tempo real (top/htop)                    │"
    echo "│  9 - Sair                                                  │"
    echo "└─────────────────────────────────────────────────────────────┘"
    echo -n "👉 Escolha uma opção: "
}

listar_todos() {
    echo ""
    echo "📋 LISTA DE TODOS OS PROCESSOS:"
    echo "═══════════════════════════════════════════════════════════════"
    ps aux --sort=-%cpu | head -30
    echo ""
    echo "📊 TOTAL DE PROCESSOS: $(ps aux | wc -l)"
}

listar_por_usuario() {
    echo ""
    echo -n "👤 Digite o nome do usuário: "
    read usuario
    echo ""
    echo "📋 PROCESSOS DO USUÁRIO: $usuario"
    echo "═══════════════════════════════════════════════════════════════"
    ps aux | grep "^$usuario" | sort -k3 -rn
    echo ""
    echo "📊 TOTAL DE PROCESSOS: $(ps aux | grep "^$usuario" | wc -l)"
}

listar_top_cpu() {
    echo ""
    echo "🔥 TOP 10 PROCESSOS (MAIOR CONSUMO DE CPU):"
    echo "═══════════════════════════════════════════════════════════════"
    ps aux --sort=-%cpu | head -11 | tail -10
}

listar_top_memoria() {
    echo ""
    echo "📈 TOP 10 PROCESSOS (MAIOR CONSUMO DE MEMÓRIA):"
    echo "═══════════════════════════════════════════════════════════════"
    ps aux --sort=-%mem | head -11 | tail -10
}

matar_processo() {
    echo ""
    echo -n "🔢 Digite o PID do processo: "
    read pid
    echo ""
    echo "Escolha o sinal:"
    echo "  1 - SIGTERM (15) - Terminação normal"
    echo "  2 - SIGKILL (9)  - Forçar terminação"
    echo "  3 - SIGSTOP (19) - Pausar processo"
    echo -n "👉 Opção: "
    read opcao_sinal
    
    case $opcao_sinal in
        1) kill -15 $pid && echo "✅ Processo $pid finalizado (SIGTERM)";;
        2) kill -9 $pid && echo "✅ Processo $pid finalizado (SIGKILL)";;
        3) kill -19 $pid && echo "✅ Processo $pid pausado (SIGSTOP)";;
        *) echo "❌ Opção inválida!";;
    esac
}

pausar_continuar() {
    echo ""
    echo -n "🔢 Digite o PID do processo: "
    read pid
    echo ""
    echo "Escolha a ação:"
    echo "  1 - Pausar (STOP)"
    echo "  2 - Continuar (CONT)"
    echo -n "👉 Opção: "
    read opcao_acao
    
    case $opcao_acao in
        1) kill -STOP $pid && echo "✅ Processo $pid pausado";;
        2) kill -CONT $pid && echo "✅ Processo $pid continuado";;
        *) echo "❌ Opção inválida!";;
    esac
    
    echo ""
    echo "📊 Status do processo:"
    ps aux | grep $pid | grep -v grep
}

arvore_processos() {
    echo ""
    echo "🌳 ÁRVORE DE PROCESSOS:"
    echo "═══════════════════════════════════════════════════════════════"
    ps auxf | head -50
    echo ""
    echo "💡 Dica: Use 'pstree' para ver árvore completa"
}

monitorar_tempo_real() {
    echo ""
    echo "📊 Monitoramento em tempo real..."
    echo "Pressione Ctrl+C para sair"
    sleep 2
    top
}

# Loop principal
while true; do
    menu_principal
    read opcao
    
    case $opcao in
        1) listar_todos ;;
        2) listar_por_usuario ;;
        3) listar_top_cpu ;;
        4) listar_top_memoria ;;
        5) matar_processo ;;
        6) pausar_continuar ;;
        7) arvore_processos ;;
        8) monitorar_tempo_real ;;
        9) echo "Saindo..."; exit 0 ;;
        *) echo "❌ Opção inválida!" ;;
    esac
    
    echo ""
    echo -n "Pressione Enter para continuar..."
    read
done
