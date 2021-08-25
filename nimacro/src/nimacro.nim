import strformat, macros

macro html(body:untyped):untyped =
  for indexB1, b1 in body:
    if b1.len() > 1:
      for indexB2, b2 in b1:
        if b2.len() > 1:
          for indexB3, b3 in b2:
            if b3.len() > 1:
              for indexB4, b4 in b3:
                if b4.len() > 1:
                  for indexB5, b5 in b4:
                    if b5.len() > 1:
                      for indexB6, b6 in b5:
                        echo fmt"          body[{repr(indexB1)}][{repr(indexB2)}][{repr(indexB3)}][{repr(indexB4)}][{repr(indexB5)}][{repr(indexB6)}]={repr(b6)}: {repr($b6.kind)}"
                    else:
                      echo fmt"        body[{repr(indexB1)}][{repr(indexB2)}][{repr(indexB3)}][{repr(indexB4)}][{repr(indexB5)}]={repr(b5)}: {repr($b5.kind)}"
                else:
                  echo fmt"      body[{repr(indexB1)}][{repr(indexB2)}][{repr(indexB3)}][{repr(indexB4)}]={repr(b4)}: {repr($b4.kind)}"
            else:
              echo fmt"    body[{repr(indexB1)}][{repr(indexB2)}][{repr(indexB3)}]={repr(b3)}: {repr($b3.kind)}"
        else:
          echo fmt"  body[{repr(indexB1)}][{repr(indexB2)}]={repr(b2)}: {repr($b2.kind)}"
    else:
      echo fmt"body[{repr(indexB1)}]={repr(b1)}: {repr($b1.kind)}"
  echo ""

when isMainModule:
  html:
    h1("HTMLのテスト")
    main:
      section:
        h2("セクション1")
        p("ほげほげ")
      section:
        h2("セクション2")
        p("ふがふが")
        p("ふごふご")
