import selenimum, logging, strformat, os
import macros

const fmtStr = "$date $time - [$levelname] "
addHandler(newConsoleLogger(fmtStr = fmtStr))

proc main() =
  info("start scraping.")
  defer:
    info("end scraping.")

  expandMacros:
    selenium "http://selenium-hub:4444/wd/hub":
      chrome:
        info("navigate to yahoo!")
        navigateTo "https://www.yahoo.co.jp/"
        let searchWord = "フィロソフィーのダンス"
        setValue "form input", searchWord
        info("search")
        click "form button"
        sleep(300)
        info(&"Page Title{getTitle()}")

        const outputPath = "output"
        screenshot &"{outputPath}/searchResults.png"
        info("save results screenshot")

        var urls: seq[string] = @[]
        elements "a.sw-Card__titleInner":
          let linkUrl = element.getAttributeValue("href")
          let linkTitle = element.getText("h3")
          info(&"No.{index} {linkTitle} {linkUrl}")
          urls.add(linkUrl)

        for i, url in urls:
          info(&"Navigate to [{url}] ...")
          navigateTo url
          info(&"Page Title:[{getTitle()}]")
          sleep(1500)
          let pngFile = &"{outputPath}/result-{$i}.png"
          screenshot pngFile
          info(&"save to [{pngFile}]")

when isMainModule:
  main()
