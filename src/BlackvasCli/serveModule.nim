import asyncdispatch, jester, strutils, os
include "index.tmpl"

proc serve*(): int =
  # blackvasプロジェクトをコンパイルして、生成したjavascriptを探索、indexTmplにpathを渡す
  
  let currentPath = os.getCurrentDir()
  var existBlackvasJson = false
  for f in walkDirRec(currentPath, {pcFile}):
    echo "file only:" & f
    if f == currentPath & "/blackvas.json":
      existBlackvasJson = true
  
  if not existBlackvasJson:
    echo "This is not Blackvas Project!"
    quit(1)

  let genJsFile = "/src/sample.js"

  routes:
    get "/":
      resp(indexTmpl(genJsFile))
  result = 0