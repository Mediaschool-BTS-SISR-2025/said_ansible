# Configuration générée par Ansible pour Powerlevel10k
# Pour personnaliser, exécutez p10k configure ou modifiez ce fichier manuellement

# Powerlevel10k configuration
POWERLEVEL9K_MODE='nerdfont-complete'

# Configuration des éléments du prompt
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(user dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time background_jobs time)

# Configuration de l'heure en temps réel
POWERLEVEL9K_TIME_FORMAT='%D{%H:%M:%S}'
POWERLEVEL9K_TIME_UPDATE_ON_COMMAND=false
typeset -g POWERLEVEL9K_TIME_BACKGROUND=black
typeset -g POWERLEVEL9K_TIME_FOREGROUND=white

# Activation de la mise à jour en temps réel (chaque seconde)
POWERLEVEL9K_EXPERIMENTAL_TIME_REALTIME=true

# Mode d'instant prompt de Powerlevel10k
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Pour personnaliser davantage, exécutez 'p10k configure' ou éditez ~/.p10k.zsh.