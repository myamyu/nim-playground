import selenimum, logging, strformat, os

const fmtStr = "$date $time - [$levelname] "
addHandler(newConsoleLogger(fmtStr=fmtStr))

proc main() =
  info("start scraping.")
  defer:
    info("end scraping.")

  let
    driver = newSeleniumWebDriver()
    session = driver.newSession()

  try:
    info("navigate to yahoo!")
    session.navigateTo("https://www.yahoo.co.jp/")
    
    let elem = session.findElement(query="form input")
    let searchWord = "フィロソフィーのダンス"
    elem.setValue(searchWord)

    info("search")
    session.findElement(query="form button").click()
    sleep(300)
    info(&"Page Title{session.getTitle()}")

    const outputPath = "output"
    session.saveScreenshot(&"{outputPath}/searchResults.png")
    info("save results screenshot")

    let links = session.findElements(query="a.sw-Card__titleInner")
    var urls: seq[string] = @[]
    for i, link in links:
      let linkUrl = link.getAttributeValue("href")
      let h3 = link.findElement(query="h3")
      let linkTitle = h3.getText()
      info(&"No.{i} {linkTitle} {linkUrl}")
      urls.add(linkUrl) 

    for i, url in urls:
      info(&"Navigate to [{url}] ...")
      session.navigateTo(url)
      info(&"Page Title:[{session.getTitle()}]")
      sleep(1500)
      let pngFile = &"{outputPath}/result-{$i}.png"
      session.saveScreenshot(pngFile)
      info(&"save to [{pngFile}]")

  except Exception as e:
    error(&"ERROR!! {e.msg}\n{e.getStackTrace()}")
  finally:
    session.deleteSession()
when isMainModule:
  main()
