import os, strutils

proc main() =
  stdout.write("\e[2J\e[0f") # 画面全消し→カーソルをリセット
  stdout.write("\e[31mHello, World!\e[m\n")
  stdout.write("\e[42m\e[4mHello, World!\e[m\n")
  stdout.write("\e[2mHello, \e[100mWorld!\e[m\n")
  stdout.write("\n")
  # プログレスバーを表示
  for i in 0..100:
    stdout.write("|\e[42m$1\e[100m$2\e[m| $3%\r" % [
      " ".repeat(i),
      " ".repeat(100 - i),
      $i,
    ])
    sleep(10)
  stdout.write("\n")

when isMainModule:
  main()
