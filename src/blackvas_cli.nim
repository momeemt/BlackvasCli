import BlackvasCli/[createModule, generateModule, serveModule]

when isMainModule:
  import cligen
  dispatchMulti(
    [createModule.create],
    [serveModule.serve],
    [generateModule.generate]
  )