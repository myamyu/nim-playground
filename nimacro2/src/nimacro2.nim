import macros

type Hoge = ref object
  fuga: string
  foo: string
  bar: string

macro hoge1(body: untyped): untyped =
  let hogehoge = newIdentNode("hogehoge")
  quote do:
    block:
      var `hogehoge` = Hoge()
      `body`

macro hoge(h: Hoge, body: untyped): untyped =
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

macro fuga(val: string): untyped =
  quote do:
    hogeAttr "fuga", `val`

macro foo(val: string): untyped =
  quote do:
    hogeAttr "foo", `val`

macro bar(val: string): untyped =
  quote do:
    hogeAttr "bar", `val`

macro getFuga(): string =
  let hogehoge = newIdentNode("hogehoge")
  quote do:
    `hogehoge`.fuga

expandMacros:
  hoge1:
    fuga "nyaaaaaaaaaaaa"
    foo "nyoooooooooo"
    bar "ほげほげ"
    let fugafuga = getFuga()
    echo fugafuga
    echo hogehoge.foo
    echo hogehoge.bar

var hg = Hoge()
hg.fuga = "あああああ"
expandMacros:
  hoge hg:
    echo hogehoge.fuga
    fuga "nyaa"
    echo hogehoge.fuga

dumpAstGen:
  var hogehoge = Hoge()
  hogehoge.fuga = "ふが"
  hogehoge.foo = "ふー"
  hogehoge.bar = "ばー"
  echo hogehoge.fuga
  echo hogehoge.foo
  echo hogehoge.bar
