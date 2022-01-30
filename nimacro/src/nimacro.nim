import strformat, macros

proc exportHtml(n: NimNode): string =
  result = ""
  if n.len() > 0:
    var closeTag = ""
    for child in n:
      result.add(exportHtml(child))
      # 閉じタグを覚えておく（空タグの場合は閉じない）
      if n.len() > 1 and child.len() == 0 and child.kind == nnkIdent:
        closeTag = fmt"</{repr(child)}>"
    # タグを閉じる
    if closeTag != "":
      result.add(closeTag)
  else:
    case n.kind
    of nnkIdent:
      result.add(fmt"<{repr(n)}>")
    of nnkStrLit:
      result.add($n)
    else: discard

macro html(body: untyped): untyped =
  var buff = "<html>"
  buff.add(exportHtml(body))
  buff.add("</html>")
  parseStmt(fmt"""
let src = "{buff}"
echo(src)
""")

expandMacros:
  html:
    head:
      title "hoge"
    body:
      h1 "HTMLのテスト"
      main:
        section:
          h2 "セクション1"
          p "ほげほげ"
          p:
            "ほげほげほげほげ"
            span "01234567"
            "ふがふが"
        section:
          h2 "セクション2"
          p "ふがふが"
          p:
            "ふごふご"
            br()
            "fufefefe"
