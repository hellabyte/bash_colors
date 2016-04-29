#!/usr/bin/env bash
# Prints colors to command line.
# TODO 
# Two Color Gradients: 
#   1st for user definitions (0-15)
#   2nd for port definitions (16-255)
# =====================================================================

function colors() {
  local cols=$(tput cols)
  local mess="-${1:-Linux}"
  local width=$(( ${#mess} + 4 )) # 3 for number length, 1 for a space.
  local maxColors=256
#  local maxUserCs=16
  read -a n <<< $( python -c "for k in range(int(float($cols)/float($width))): print(k)")
  local n_last=$((${n[@]:(-1)}))
  read -a m <<< $( python -c "for k in range(int(256./float($n_last))+1): print(k)")
  local c=0
  for i in ${m[@]}; do
    for j in ${n[@]}; do
      local str=$( printf "%.3d%s " $c $mess )
      eval 'echo -ne "\033[38;05;${c}m${str}\033[m"'
      let c++
      [[ $c -ge $maxColors ]] && echo '' && return
#      [[ $c -eq $maxUserCs ]] && echo '' || :
    done
    echo ''
  done
  echo ''
  echo ${m[@]:(-1)} $n_last
}

colors $1
