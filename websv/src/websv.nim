import jester, json

routes:
  get "/":
    resp %*{
      "message": "こんにちはこんにちは",
    }

when isMainModule:
  runForever()
