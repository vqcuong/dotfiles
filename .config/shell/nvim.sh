# nvim_exe=$(brew --prefix)/bin/nvim
nvim_exe=$(which nvim)
nvim() {
  if [[ "$1" == "" ]]; then
    $nvim_exe
  elif [[ -d $1 && $(realpath "$1") != "$PWD" ]]; then
    cd "$1" && $nvim_exe .
  else
    $nvim_exe "$1"
  fi
}
