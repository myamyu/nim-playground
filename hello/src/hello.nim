#[
  ハローって言う
]#
proc sayHello(name:string) =
  echo "Hello, ", name, "!!"

when isMainModule:
  echo "your name:"
  var input = stdin.readLine
  sayHello(if input == "": "World" else: input)
