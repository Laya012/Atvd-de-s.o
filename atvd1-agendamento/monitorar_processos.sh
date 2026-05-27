#!/bin/bash

# Script: monitorar_processos.sh
# Função: Lista os processos rodando e salva em /monitorado.txt

DATA=$(date '+%Y-%m-%d %H:%M:%S')

echo "=========================================" >> /monitorado.txt
echo "Monitoramento em: $DATA" >> /monitorado.txt
echo "=========================================" >> /monitorado.txt
ps aux >> /monitorado.txt
echo "" >> /monitorado.txt

echo "✅ Processos monitorados em $DATA"
