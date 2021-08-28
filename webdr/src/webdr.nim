import webdriver
import logging, strformat

const fmtStr = "$date $time - [$levelname] "
let logger = newConsoleLogger(fmtStr=fmtStr)
addHandler(logger)

proc main() =
  info("start!")
  defer:
    info("end.")
  try:
    let driver = newWebDriver()
    debug("create session")
    let session = driver.createSession()
    info("navigate to hotpepper.")
    session.navigate("https://www.hotpepper.jp/SA11/lst")
    let safeElem = session.findElement("h1")
    echo $safeElem
    # TODO どうやって要素の情報を得るのか・・・？うまくいかん。。。
    defer:
      session.close()
      info("session closed")
  except Exception as e:
    error(fmt"なんかエラーになったよ。 {e.msg}")

when isMainModule:
  main()
