#!/bin/bash

# Script: login_logout.sh
# Função: Informa data/hora e conteúdo das pastas ao logar/deslogar

DATA_HORA=$(date '+%Y-%m-%d %H:%M:%S')
USUARIO=$(whoami)
TIPO=$1  # "login" ou "logout"

LOG_FILE="$HOME/log_acesso.txt"

# Função para listar conteúdo das pastas
listar_pastas() {
    echo "📁 CONTEÚDO DA ÁREA DE TRABALHO:"
    ls -la "$HOME/Desktop/" 2>/dev/null || echo "   Pasta Desktop não encontrada"
    
    echo ""
    echo "📁 CONTEÚDO DOS DOCUMENTOS:"
    ls -la "$HOME/Documentos/" 2>/dev/null || echo "   Pasta Documentos não encontrada"
    
    echo ""
    echo "📁 CONTEÚDO DA PASTA PESSOAL:"
    ls -la "$HOME/" 2>/dev/null | head -20
}

# Registrar no log
echo "=========================================" >> $LOG_FILE
echo "$TIPO - $USUARIO - $DATA_HORA" >> $LOG_FILE
echo "=========================================" >> $LOG_FILE

# Executar ação baseada no tipo
if [ "$TIPO" = "login" ]; then
    echo "🔓 LOGIN realizado em $DATA_HORA"
    echo "🔓 LOGIN - $DATA_HORA" >> $LOG_FILE
    listar_pastas >> $LOG_FILE
    
elif [ "$TIPO" = "logout" ]; then
    echo "🔒 LOGOUT realizado em $DATA_HORA"
    echo "🔒 LOGOUT - $DATA_HORA" >> $LOG_FILE
    listar_pastas >> $LOG_FILE
    
    # Chamar script de limpeza
    ~/atividade-so/atvd1-agendamento/limpeza_logout.sh
else
    echo "❌ Use: $0 [login|logout]"
    exit 1
fi

echo "" >> $LOG_FILE
echo "✅ Registrado em $LOG_FILE"
