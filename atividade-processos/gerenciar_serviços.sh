cat > gerenciar_servicos.sh << 'FIM'
#!/bin/bash

# ==============================================
# SCRIPT: gerenciar_servicos.sh
# FUNÇÃO: Gerenciar serviços do systemd
# ==============================================

echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║              GERENCIAMENTO DE SERVIÇOS (SYSTEMD)              ║"
echo "╚═══════════════════════════════════════════════════════════════╝"

menu_servicos() {
    echo ""
    echo "┌─────────────────────────────────────────────────────────────┐"
    echo "│                      MENU DE SERVIÇOS                       │"
    echo "├─────────────────────────────────────────────────────────────┤"
    echo "│  1 - Listar todos os serviços                              │"
    echo "│  2 - Listar serviços ativos                                │"
    echo "│  3 - Listar serviços habilitados (iniciam no boot)         │"
    echo "│  4 - Iniciar um serviço                                    │"
    echo "│  5 - Parar um serviço                                      │"
    echo "│  6 - Reiniciar um serviço                                  │"
    echo "│  7 - Habilitar serviço (iniciar no boot)                   │"
    echo "│  8 - Desabilitar serviço (não iniciar no boot)             │"
    echo "│  9 - Ver status de um serviço                              │"
    echo "│ 10 - Serviços que podem ser desabilitados                  │"
    echo "│ 11 - Sair                                                  │"
    echo "└─────────────────────────────────────────────────────────────┘"
    echo -n "👉 Escolha uma opção: "
}

listar_servicos() {
    echo ""
    echo "📋 LISTA DE TODOS OS SERVIÇOS:"
    echo "═══════════════════════════════════════════════════════════════"
    systemctl list-unit-files --type=service | head -30
}

listar_servicos_ativos() {
    echo ""
    echo "✅ SERVIÇOS ATIVOS:"
    echo "═══════════════════════════════════════════════════════════════"
    systemctl list-units --type=service --state=running
}

listar_servicos_habilitados() {
    echo ""
    echo "🔌 SERVIÇOS HABILITADOS (iniciam no boot):"
    echo "═══════════════════════════════════════════════════════════════"
    systemctl list-unit-files --type=service | grep enabled | head -30
}

iniciar_servico() {
    echo ""
    echo -n "🔧 Nome do serviço: "
    read servico
    echo ""
    sudo systemctl start $servico
    if [ $? -eq 0 ]; then
        echo "✅ Serviço $servico iniciado com sucesso!"
    else
        echo "❌ Erro ao iniciar serviço $servico"
    fi
}

parar_servico() {
    echo ""
    echo -n "🔧 Nome do serviço: "
    read servico
    echo ""
    sudo systemctl stop $servico
    if [ $? -eq 0 ]; then
        echo "✅ Serviço $servico parado com sucesso!"
    else
        echo "❌ Erro ao parar serviço $servico"
    fi
}

reiniciar_servico() {
    echo ""
    echo -n "🔧 Nome do serviço: "
    read servico
    echo ""
    sudo systemctl restart $servico
    if [ $? -eq 0 ]; then
        echo "✅ Serviço $servico reiniciado com sucesso!"
    else
        echo "❌ Erro ao reiniciar serviço $servico"
    fi
}

habilitar_servico() {
    echo ""
    echo -n "🔧 Nome do serviço: "
    read servico
    echo ""
    sudo systemctl enable $servico
    if [ $? -eq 0 ]; then
        echo "✅ Serviço $servico habilitado (iniciará no boot)!"
    else
        echo "❌ Erro ao habilitar serviço $servico"
    fi
}

desabilitar_servico() {
    echo ""
    echo -n "🔧 Nome do serviço: "
    read servico
    echo ""
    sudo systemctl disable $servico
    if [ $? -eq 0 ]; then
        echo "✅ Serviço $servico desabilitado (não iniciará no boot)!"
    else
        echo "❌ Erro ao desabilitar serviço $servico"
    fi
}

status_servico() {
    echo ""
    echo -n "🔧 Nome do serviço: "
    read servico
    echo ""
    systemctl status $servico
}

servicos_desabilitar() {
    echo ""
    echo "⚠️ SERVIÇOS QUE PODEM SER DESABILITADOS COM SEGURANÇA:"
    echo "═══════════════════════════════════════════════════════════════"
    cat << 'INFO'
┌─────────────────────────────────────────────────────────────────────┐
│ Serviço              │ Descrição                    │ Seguro?       │
├─────────────────────────────────────────────────────────────────────┤
│ cups                 │ Serviço de impressão         │ Se não usa     │
│ bluetooth            │ Bluetooth                    │ Se não usa     │
│ avahi-daemon         │ Descoberta de rede           │ Sim           │
│ whoopsie             │ Relatório de erros           │ Sim           │
│ speech-dispatcher    │ Acessibilidade               │ Sim           │
│ ModemManager         │ Modem 3G/4G                  │ Se não usa    │
│ pppd-dns             │ Conexão discada              │ Se não usa    │
│ brltty               │ Suporte a Braille            │ Se não usa    │
│ snapd                │ Gerenciador de snaps         │ Cuidado!      │
│ NetworkManager-wait  │ Espera rede                  │ Pode causar   │
└─────────────────────────────────────────────────────────────────────┘

PARA DESABILITAR:
  sudo systemctl disable <servico>
  sudo systemctl stop <servico>

PARA VERIFICAR:
  systemctl status <servico>
INFO
}

while true; do
    menu_servicos
    read opcao
    
    case $opcao in
        1) listar_servicos ;;
        2) listar_servicos_ativos ;;
        3) listar_servicos_habilitados ;;
        4) iniciar_servico ;;
        5) parar_servico ;;
        6) reiniciar_servico ;;
        7) habilitar_servico ;;
        8) desabilitar_servico ;;
        9) status_servico ;;
        10) servicos_desabilitar ;;
        11) echo "Saindo..."; exit 0 ;;
        *) echo "❌ Opção inválida!" ;;
    esac
    
    echo ""
    echo -n "Pressione Enter para continuar..."
    read
done
FIM

chmod +x gerenciar_servicos.sh
