import macros

type Hoge = ref object
  fuga: string
  foo: string
  bar: string

macro hoge(body: untyped): untyped =
  let hogehoge = newIdentNode("hogehoge")
  quote do:
    block:
      var `hogehoge` = Hoge()
      `body`

macro hoge2(h: Hoge, body: untyped): untyped =
  let hogehoge = newIdentNode("hogehoge")
  quote do:
    block:
      var `hogehoge` = `h`
      `body`

macro hogeAttr(name: string, val: string): untyped =
  let hogehoge = newIdentNode("hogehoge")
  let attr = newIdentNode(strVal(name))
  quote do:
    `hogehoge`.`attr` = `val`

macro fuga(head: untyped): untyped =
  let val = newLit(strVal(head))
  quote do:
    hogeAttr "fuga", `val`

macro foo(head: untyped): untyped =
  let val = newLit(strVal(head))
  quote do:
    hogeAttr "foo", `val`

macro bar(head: untyped): untyped =
  let val = newLit(strVal(head))
  quote do:
    hogeAttr "bar", `val`

expandMacros:
  hoge:
    fuga nyaaaaaaa
    foo nyooooooooooo
    bar "ほげほげ"
    echo hogehoge.fuga
    echo hogehoge.foo
    echo hogehoge.bar

var hg = Hoge()
hg.fuga = "あああああ"
expandMacros:
  hoge2 hg:
    echo hogehoge.fuga
    fuga nyaa
    echo hogehoge.fuga

dumpAstGen:
  var hogehoge = Hoge()
  hogehoge.fuga = "ふが"
  hogehoge.foo = "ふー"
  hogehoge.bar = "ばー"
  echo hogehoge.fuga
  echo hogehoge.foo
  echo hogehoge.bar
