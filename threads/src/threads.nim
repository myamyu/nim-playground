import random

proc hoge(args:tuple[a:int, name:string]) {.thread.} =
  echo args.name, ": はじめるよー。 ", $args.a, " tasks."
  for i in 0..args.a:
    let p = i.float / args.a.float * 100.0
    echo args.name, ": ", p, "%"
  echo args.name, ": おわったよー。"

when isMainModule:
  var ths:array[10, Thread[tuple[a:int, name:string]]]
  randomize()
  for i in 1..5:
    let maxTasks = rand(1..100)
    createThread(ths[i], hoge, (maxTasks, "Task " & $i))
  joinThreads(ths)
