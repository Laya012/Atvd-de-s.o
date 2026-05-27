#!/bin/bash

# Script: limpeza_logout.sh
# Função: Exclui arquivos de Download, cookies e temporários no logout

USUARIO=$(whoami)
DATA=$(date '+%Y-%m-%d %H:%M:%S')
LOG_LIMPEZA="$HOME/limpeza_logout.log"

echo "=========================================" >> $LOG_LIMPEZA
echo "🧹 LIMPEZA DE LOGOUT - $DATA" >> $LOG_LIMPEZA
echo "=========================================" >> $LOG_LIMPEZA

# 1. Limpar Downloads
if [ -d "$HOME/Downloads" ]; then
    echo "🗑️ Removendo arquivos de Downloads..." >> $LOG_LIMPEZA
    rm -rf "$HOME/Downloads/"* 2>/dev/null
    echo "   ✅ Downloads limpo" >> $LOG_LIMPEZA
fi

# 2. Limpar cookies do Browser (Firefox)
if [ -d "$HOME/.mozilla/firefox" ]; then
    echo "🗑️ Removendo cookies do Firefox..." >> $LOG_LIMPEZA
    find "$HOME/.mozilla/firefox" -name "cookies.sqlite" -delete 2>/dev/null
    echo "   ✅ Cookies do Firefox removidos" >> $LOG_LIMPEZA
fi

# 3. Limpar cookies do Chrome/Chromium
if [ -d "$HOME/.config/google-chrome" ]; then
    echo "🗑️ Removendo cookies do Chrome..." >> $LOG_LIMPEZA
    rm -rf "$HOME/.config/google-chrome/Default/Cookies" 2>/dev/null
    echo "   ✅ Cookies do Chrome removidos" >> $LOG_LIMPEZA
fi

# 4. Limpar arquivos temporários
echo "🗑️ Removendo arquivos temporários..." >> $LOG_LIMPEZA
rm -rf /tmp/* 2>/dev/null
rm -rf "$HOME/.cache/"* 2>/dev/null
rm -rf "$HOME/.local/share/Trash/"* 2>/dev/null
echo "   ✅ Temporários limpos" >> $LOG_LIMPEZA

echo "🧹 Limpeza concluída em $DATA" >> $LOG_LIMPEZA
echo "" >> $LOG_LIMPEZA

echo "✅ Limpeza de logout realizada com sucesso!"
