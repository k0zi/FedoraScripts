# /etc/bashrc

#Aliases
alias docker=podman

#environment variable
export DOCKER_HOST=unix:///run/user/1000/podman/podman.sock

#oh my posh
eval "$(oh-my-posh init bash --config /etc/ohmyposh/gruvbox.omp.json)"
