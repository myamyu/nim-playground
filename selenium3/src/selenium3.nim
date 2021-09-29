import halonium, logging, strformat, os, options

const fmtStr = "$date $time - [$levelname] "
addHandler(newConsoleLogger(fmtStr=fmtStr))

proc main() =
  info("start scraping")
  defer:
    info("end scraping.")

  var session = createRemoteSession(browser=Chrome, url="http://localhost:4444/wd/hub")

  try:
    info("navigate to yahoo!")
    session.navigate("https://www.yahoo.co.jp")

    let elem = session.waitForElement("form input").get()
    let searchWord = "フィロソフィーのダンス"
    elem.sendKeys(searchWord)

    info("search")
    session.waitForElement("form button").get().click()
    sleep(300)
    info(&"Page TItle: {session.title()}")

    const outputPath = "output"
    discard session.saveScreenShotTo(&"{outputPath}/searchResult.png")
    info("save results screenshot")

    let links = session.waitForElements("a.sw-Card__titleInner")
    var urls: seq[string] = @[]
    for i, link in links:
      let linkUrl = link.attribute("href")
      let h3 = link.findElement("h3").get()
      let linkTitle = h3.text()
      info(&"No.{i} {linkTitle} {linkUrl}")
      urls.add(linkUrl) 

    for i, url in urls:
      info(&"Navigate to [{url}] ...")
      session.navigate(url)
      info(&"Page Title:[{session.title()}]")
      sleep(1500)
      let pngFile = &"{outputPath}/result-{$i}.png"
      discard session.saveScreenShotTo(pngFile)
      info(&"save to [{pngFile}]")

  except Exception as e:
    error(&"ERROR!! {e.msg}\n{e.getStackTrace()}")
  finally:
    session.stop()

when isMainModule:
  main()
