import logging

const fmtStr = "$date $time - [$levelname] "
let logger1 = newConsoleLogger(fmtStr = fmtStr)
let logger2 = newFileLogger(filename = "./logs/app.log", fmtStr = fmtStr)
let logger3 = newRollingFileLogger(filename = "./logs/app-rolling.log",
    fmtStr = fmtStr)

addHandler(logger1)
addHandler(logger2)
addHandler(logger3)

when isMainModule:
  debug("でばっぐだよ")
  info("いんふぉだよ")
  notice("noticeだよ")
  warn("けいこくだよ")
  error("えらーだよ")
  fatal("やばいよやばいよ")
