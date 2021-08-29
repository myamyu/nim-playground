import httpclient, uri, json, strformat

type SessionId = string

const driverUrl = "http://localhost:4444/wd/hub".parseUri()
let capabilities = %*{"desiredCapabilities":{"browserName":"firefox"},"requiredCapabilities":{}}
let client = newHttpClient()

#[
  WebDriverのセッションを確立
]#
proc newWebDriverSession(): SessionId =
  # seleniumの状態を確認
  let resp = client.getContent($(driverUrl / "status"))
  let obj = parseJson(resp)
  let ready = obj{"value", "ready"}
  if ready.isNil():
    raise newException(Exception, "なんかおかしい")
  if not ready.getBool():
    raise newException(Exception, "Seleniumが準備できていないよ。")

  # sessionを作る
  let sessionResp = client.postContent($(driverUrl / "session"), $capabilities)
  let sessionObj = parseJson(sessionResp)
  let sessionId = sessionObj{"sessionId"}
  if sessionId.isNil():
    raise newException(Exception, "Sessionが作れなかったよ。")
  return sessionId.getStr()

#[
  WebDriverのSessionを閉じる
]#
proc closeSession(sessionId: SessionId) =
  let resp = client.deleteContent($(driverUrl / "session" / sessionId))
  let obj = parseJson(resp)
  let state = obj{"state"}
  if state.isNil():
    raise newException(Exception, "delete session失敗")
  if state.getStr() != "success":
    raise newException(Exception, fmt"delete session失敗: {state.getStr()}")
  echo fmt"session deleted. [{sessionId}]"

#[
  指定されたURLへ
]#
proc navigateTo(sessionId: SessionId, url: string) =
  let body = %*{"url": url}
  let resp = client.postContent($(driverUrl / "session" / sessionId / "url"), $body)
  let obj = parseJson(resp)
  let state = obj{"state"}
  if state.isNil():
    raise newException(Exception, "navigate失敗")
  if state.getStr() != "success":
    raise newException(Exception, fmt"navigate失敗: {state.getStr()}")

#[
  ページのタイトルを取得
]#
proc getTitle(sessionId: SessionId): string =
  let resp = client.getContent($(driverUrl / "session" / sessionId / "title"))
  let obj = parseJson(resp)
  let title = obj{"value"}
  if title.isNil():
    raise newException(Exception, "タイトルなんてなかったんや")
  return title.getStr()

proc main =
  let sessionId = newWebDriverSession()
  defer:
    closeSession(sessionId)
  navigateTo(sessionId, "https://qiita.com/myamyu/items/318ee8ac83b8ec1a8c80")
  echo getTitle(sessionId)

when isMainModule:
  main()
