  # ASDF
  git clone https://github.com/asdf-vm/asdf.git "/home/joseph/.asdf" --branch v0.9.0
  . "/home/joseph/.asdf/asdf.sh"

  plugins=$(echo "github-cli
    helm
    helmfile
    kops
    kubectl
    kustomize
    sops
  " | tr -d '[:blank:]')

  # install latest
  # asdf plugin list | xargs -r -I % -d\\n -n1 bash -c 'asdf install % latest'
  # uninstall old versions:
  # asdf plugin list | xargs -r -I % -d\\n -n1 bash -c 'asdf list % | tr -d "[:blank:]" | sort -rV | tail +2 | xargs -r -d\\n -n1 asdf uninstall %'
  # update global tool versions
  # asdf plugin list | xargs -r -I % -d\\n -n1 bash -c 'asdf list % | tr -d "[:blank:]" | sort -rV | head | xargs -r -d\\n -n1 asdf global %'
  echo "${plugins}" | xargs -d\\n -n1 asdf plugin add
  echo "${plugins}" | xargs -I % -d\\n -n1 bash -c 'asdf install % latest'
  echo "${plugins}" | xargs -r -I % -d\\n -n1 bash -c 'asdf list % | tr -d "[:blank:]" | sort -rV | head | xargs -r -d\\n -n1 asdf global %'

  mkdir -p "/home/joseph/git/work" "/home/joseph/git/code"

  git clone https://github.com/jetersen/dotfiles.git "/home/joseph/git/code/dotfiles"
