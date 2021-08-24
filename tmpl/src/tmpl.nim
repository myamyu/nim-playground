#[
  htmlのタグtemplateを作るtemplate
]#
template htmlTag(tag: untyped): untyped =
  template tag(body: untyped) =
    block:
      echo "<" & astToStr(tag) & ">"
      body
      echo "</" & astToStr(tag) & ">"

# HTMLのタグを宣言
#[
  ここをloopで乗り切りたい場合はmacroを使えってなる。
  https://forum.nim-lang.org/t/1149

  htmlTags(h1, h2, h3) みたいなのはできなかった・・・
]#
htmlTag(html)
htmlTag(p)
htmlTag(h1)
htmlTag(h2)
htmlTag(section)
htmlTag(main)

when isMainModule:
  html:
    h1:
      echo "たいとるだよ"
    main:
      section:
        h2:
          echo "セクションだよ"
        p:
          echo "本文だよ"
      section:
        h2:
          echo "セクション2だよ"
        p:
          echo "本文2だよ"
