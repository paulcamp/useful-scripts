function open_sensible() {
  solutions=()
  while IFS=  read -r -d $'\0'; do
    solutions+=("$REPLY")
  done < <(find . -maxdepth 2 -regextype posix-extended -type f -iregex '^.*\.(sln|iml)$' -print0)
  solutions_count=${#solutions[@]}
  if [ $solutions_count -eq 0 ]; then
    ${EDITOR:=vim} .
    return
  fi
  if [ $solutions_count -eq 1 ]; then
    \start ${solutions[0]}
    return
  fi
  PS3="Pick a file to open: "

  select FILENAME in ${solutions[*]}; do
    case $FILENAME in *)
      if [ -n "$FILENAME" ]; then
        echo "Opening $FILENAME"
        \start "$FILENAME"
      fi
      break
      ;;
    esac
  done
}

alias os=open_sensible
