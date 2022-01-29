import asynchttpserver, asyncdispatch
import logging, strformat
import system/ansi_c

const fmtStr = "$date $time - [$levelname] "
let logger = newConsoleLogger(fmtStr = fmtStr)

addHandler(logger)

proc main() =
  info("starting web server.")

  var server = newAsyncHttpServer()

  # Hello, Worldしか返さないWeb Server
  proc cb(req: Request) {.async.} =
    info(fmt"req {req.reqMethod} {req.url.path}")
    debug(fmt"  header {req.headers}")

    let headers = {
      "Content-Type": "text/plain; charset=utf-8",
    }
    await req.respond(
      Http200,
      "Hello, World!",
      headers.newHttpHeaders()
    )

  # graceful shutdown
  proc shutdown(fd: AsyncFD): bool =
    info("Server Shutdown on SIGINT")
    server.close()
    quit(QuitSuccess)
  addSignal(SIGINT, shutdown)

  info("listen...8080")
  waitFor server.serve(Port(8080), cb)

when isMainModule:
  main()
