import parseopt2
import BlackvasCli/create as create

if isMainModule:
  for kind, key, val in getopt() :
    case kind
    of cmdArgument:
      discard
    of cmdLongOption:
      case key:
      of "create":
        create.interaction($val)
    of cmdShortOption:
      echo "オプション2 > ", key, val
    of cmdEnd:
      echo "終了"