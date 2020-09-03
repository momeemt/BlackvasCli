import BlackvasCli/[createModule, serveModule]

when isMainModule:
  import cligen
  dispatchMulti(
    [createModule.create],
    [serveModule.serve]
  )