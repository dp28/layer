#! /usr/bin/env bash
COMMANDS="append config delete list new read remove render show write "
HELP_OPTIONS="-h --help"
TEMPLATE_OPTIONS="$HELP_OPTIONS -t --template"
READ_OPTIONS="$TEMPLATE_OPTIONS -k --key"
WRITE_OPTIONS="$READ_OPTIONS -v --value"
NEW_OPTIONS="$TEMPLATE_OPTIONS"
RENDER_OPTIONS="$NEW_OPTIONS --row-height --column-width --profile --image-file"

complete_keys() {
  local arg="$1"
  local previous="$2"
  local keys="${@:3}"

  if ! [[ $previous =~ "-".+ ]]; then
    if ! [[ $arg =~ "-".+ && $keys =~ .*"-$arg"[a-z]+ ]]; then
      [[ $keys =~ .*"$arg"[a-z]+ ]] && echo $keys
    fi
  elif ! [[ $arg =~ "-".* ]]; then
    echo $keys
  fi
}

if [[ $COMMANDS =~ .*"$2"[a-z]+ ]]; then
  echo $COMMANDS
else
  last="${@: -1}"
  if [ "$last" = "$2" ]; then
    last=""
  fi

  previous="${@:(-2):1}"
  if [[ "$previous" = "$2" || "$previous" = "$1" ]]; then
    previous=""
  fi

  case "$2" in
    append)
      complete_keys "$last" "$previous" $WRITE_OPTIONS
      ;;

    config)
      complete_keys "$last" "$previous" $RENDER_OPTIONS
      ;;

    delete)
      complete_keys "$last" "$previous" $TEMPLATE_OPTIONS
      ;;

    new)
      complete_keys "$last" "$previous" $NEW_OPTIONS
      ;;

    read)
      complete_keys "$last" "$previous" $READ_OPTIONS
      ;;

    remove)
      complete_keys "$last" "$previous" $READ_OPTIONS
      ;;

    render)
      complete_keys "$last" "$previous" $RENDER_OPTIONS
      ;;

    show)
      complete_keys "$last" "$previous" $NEW_OPTIONS
      ;;

    write)
      complete_keys "$last" "$previous" $WRITE_OPTIONS
      ;;
  esac
fi
