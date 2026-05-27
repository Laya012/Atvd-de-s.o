#!/bin/bash

echo "========================================="
echo "ATIVIDADE 3 S.O - GERENCIAMENTO DE PROCESSOS"
echo "========================================="

# 1. O que são processos?
echo ""
echo "📌 1. O QUE SÃO PROCESSOS?"
echo "========================================="
cat << 'FIM'
Um processo é um programa em execução. Ele possui:
- PID (Process ID) - Identificador único
- Estado (Running, Sleeping, Stopped, Zombie)
- Prioridade
- CPU e memória alocada
- Contexto (registradores, stack, heap)

Diferença entre Programa e Processo:
- Programa: código estático no disco
- Processo: instância em execução na memória
FIM

# 2. Programas que monitoram processos no Windows
echo ""
echo "📌 2. PROGRAMAS QUE MONITORAM PROCESSOS NO WINDOWS"
echo "========================================="
cat << 'FIM'
1. Gerenciador de Tarefas (Task Manager)
   - Ctrl + Shift + Esc
   - Ctrl + Alt + Del

2. Monitor de Recursos (Resource Monitor)
   - resmon.exe

3. Performance Monitor
   - perfmon.exe

4. Process Explorer (Sysinternals)
   - Ferramenta avançada da Microsoft

5. PowerShell com cmdlets:
   - Get-Process
   - Get-Service
FIM

# 3. Comandos para gerenciamento no Windows
echo ""
echo "📌 3. COMANDOS PARA GERENCIAR PROCESSOS NO WINDOWS (CMD/PowerShell)"
echo "========================================="
cat << 'FIM'
=== CMD (Command Prompt) ===
tasklist                 - Lista processos
taskkill /PID 1234       - Mata processo pelo PID
taskkill /IM notepad.exe - Mata processo pelo nome
start notepad.exe        - Inicia um processo
wmirc process            - Informações detalhadas

=== PowerShell ===
Get-Process              - Lista processos
Stop-Process -ID 1234    - Mata processo
Start-Process notepad    - Inicia processo
Get-Service              - Lista serviços
Stop-Service -Name spooler - Para serviço
Start-Service -Name spooler - Inicia serviço
FIM

# 4. Status de um processo
echo ""
echo "📌 4. STATUS DE UM PROCESSO"
echo "========================================="
cat << 'FIM'
┌─────────┬──────────────────────────────────────┐
│ Status  │ Significado                          │
├─────────┼──────────────────────────────────────┤
│ R (Running)   │ Em execução na CPU             │
│ S (Sleeping)  │ Aguardando recurso/evento      │
│ D (Uninterruptible) │ Espera de I/O (não mata) │
│ Z (Zombie)    │ Processo filho finalizado      │
│ T (Stopped)   │ Suspenso (Ctrl+Z ou kill -STOP)│
│ I (Idle)      │ Inativo                         │
└─────────┴──────────────────────────────────────┘
FIM

# 5. Comandos para ativar cada status no Linux
echo ""
echo "📌 5. COMANDOS PARA ATIVAR CADA STATUS (LINUX)"
echo "========================================="
cat << 'FIM'

=== PROCESSO EM EXECUÇÃO (R) ===
./meu_programa &
ps aux | grep meu_programa

=== PROCESSO EM SLEEP (S) ===
sleep 300 &   # Processo dormindo

=== PROCESSO STOPPED (T) ===
kill -STOP <PID>    # Para o processo
kill -CONT <PID>    # Continua o processo

=== PROCESSO ZOMBIE (Z) ===
# Criar processo zumbi (exemplo em C)
# kill -CHLD <PID> para reaper

=== PROCESSO EM BACKGROUND ===
comando &           # Executa em background
jobs                # Lista jobs em background
fg %1              # Traz para foreground
bg %1              # Envia para background

=== EXEMPLOS PRÁTICOS ===
# Iniciar processo em background
ping google.com &

# Ver status
ps -l

# Parar processo
kill -STOP <PID>

# Continuar processo
kill -CONT <PID>

# Matar processo
kill -9 <PID>      # Força a morte
kill -15 <PID>     # Termina normalmente

EOF

# 6. Demonstração prática
echo ""
echo "📌 6. DEMONSTRAÇÃO PRÁTICA - LINUX"
echo "========================================="

# Criar um processo de teste
echo "🔧 Iniciando processo de teste (sleep 60)..."
sleep 60 &
PID_SLEEP=$!
echo "PID do processo: $PID_SLEEP"

# Mostrar status
echo ""
echo "📊 Status do processo (ps aux | grep $PID_SLEEP):"
ps aux | grep $PID_SLEEP | grep -v grep

# Parar o processo
echo ""
echo "⏸️ Parando processo (kill -STOP)..."
kill -STOP $PID_SLEEP
sleep 1
ps aux | grep $PID_SLEEP | grep -v grep

# Continuar o processo
echo ""
echo "▶️ Continuando processo (kill -CONT)..."
kill -CONT $PID_SLEEP
sleep 1
ps aux | grep $PID_SLEEP | grep -v grep

# Matar o processo
echo ""
echo "💀 Matando processo..."
kill -9 $PID_SLEEP
echo "Processo finalizado!"

echo ""
echo "✅ Demonstração concluída!"
