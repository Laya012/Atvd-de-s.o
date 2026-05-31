cat > README.md << 'FIM'
# 📊 Atividade - Gerenciamento de Processos

## 📁 Scripts Disponíveis

| Script | Função |
|--------|--------|
| `gerenciar_processos.sh` | Menu interativo para gerenciar processos |
| `monitorar_recursos.sh` | Monitora CPU, memória, disco e processos |
| `gerenciar_servicos.sh` | Gerencia serviços do systemd |
| `analisar_desempenho.sh` | Analisa alto consumo e processos zombie |
| `configurar_cron_processos.sh` | Agenda monitoramento automático |

## 🚀 Como Usar

```bash
# Dar permissão de execução
chmod +x *.sh

# Gerenciar processos (menu interativo)
./gerenciar_processos.sh

# Monitorar recursos
./monitorar_recursos.sh

# Gerenciar serviços
./gerenciar_servicos.sh

# Analisar desempenho
./analisar_desempenho.sh

# Configurar agendamentos
./configurar_cron_processos.sh
