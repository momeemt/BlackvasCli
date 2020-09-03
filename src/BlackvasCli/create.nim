import os, osproc, terminal, colors, strformat

proc mkdirCmd(path: string)
proc touchCmd(path: string)

proc interaction*(projectName: string) =
  enableTrueColors()
  setForegroundColor(stdout, parseColor("#ffa500"))
  echo "\e[1m" & "Blackvas CLI v0.1.0" & "\e[0m"
  resetAttributes(stdout)
  let projectPath: string = os.getCurrentDir() & "/" & projectName
  echo "✨ Creating project in " & projectPath & "."

  stdout.write "✏️  Please enter author name.  "
  var enteredAuthor: string = stdin.readLine
  while (enteredAuthor == ""):
    stdout.write "Please enter author name.  "
    enteredAuthor = stdin.readLine
  
  stdout.write "✏️  Please enter description. [default: A new awesome Blackvas project]  "
  var enteredDescription: string = "A new awesome Blackvas project"
  enteredDescription = stdin.readLine
  if (enteredDescription == ""):
    enteredDescription = "A new awesome Blackvas project"
  
  stdout.write "✏️  Please enter version. [default: 0.1.0]  "
  var enteredVersion: string = "0.1.0"
  enteredVersion = stdin.readLine
  if (enteredVersion == ""):
    enteredVersion = "0.1.0"

  stdout.write "❓ Would you adopt Atomic Design? [y/n]  "
  var yn: string = stdin.readLine
  while (yn != "y" and yn != "n"):
    stdout.write "Please enter y or n.  "
    yn = stdin.readLine

  echo ""
  mkdirCmd(projectPath)
  let rootNimPath = projectPath & "/" & projectName & ".nimble"
  touchCmd(rootNimPath)
  echo fmt"📄  {rootNimPath}"
  var rootNimFile: File = open(rootNimPath, FileMode.fmWrite)
  rootNimFile.writeLine fmt"""
# Package

version       = "{enteredVersion}"
author        = "{enteredAuthor}"
description   = "{enteredDescription}"
license       = "MIT"
srcDir        = "src"
backend       = "js"

# Dependencies

requires "nim >= 1.0.6"
requires "blackvas >= 1.0.0"
"""
  mkdirCmd(projectPath & "/src")
  touchCmd(projectName & "/src/" & projectName & ".nim")
  echo fmt"📄  /src/{projectName}.nim"

  if (yn == "y"):
    mkdirCmd(projectPath & "/src/components")
    mkdirCmd(projectPath & "/src/components/atoms")
    touchCmd(projectName & "/src/components/atoms/atom.nim")
    echo "📄  /src/components/atoms/atom.nim"
    mkdirCmd(projectPath & "/src/components/molecules")
    touchCmd(projectName & "/src/components/molecules/molecule.nim")
    echo "📄  /src/components/molecules/molecule.nim"
    mkdirCmd(projectPath & "/src/components/organisms")
    touchCmd(projectName & "/src/components/organisms/organism.nim")
    echo "📄  /src/components/organisms/organism.nim"
    mkdirCmd(projectPath & "/src/components/templates")
    touchCmd(projectName & "/src/components/templates/template.nim")
    echo "📄  /src/components/templates/template.nim"
    mkdirCmd(projectPath & "/src/views")
    touchCmd(projectName & "/src/views/hello_blackvas.nim")
    echo "📄  /src/views/hello_blackvas.nim"
  echo ""
  stdout.write fmt"🎉 Successfully created project "
  setForegroundColor(stdout, fgRed)
  stdout.write projectName
  resetAttributes(stdout)
  echo "."
  echo "👉  Get started with the following commands:"
  echo "    $ cd ", projectName
  echo "    $ blackvas_cli serve"

proc mkdirCmd(path: string) =
  discard execCmd "mkdir " & path

proc touchCmd(path: string) =
  discard execCmd "touch " & path