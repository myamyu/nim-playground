import webdriver
import logging, strformat, options

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
    let safeElem = session.findElement(".shopDetailStoreName")
    let elem = safeElem.get()
    info(fmt"最初のお店:{elem.getText()}")

    defer:
      session.close()
      info("session closed")
  except Exception as e:
    error(fmt"なんかエラーになったよ。 {e.msg}")

when isMainModule:
  main()
