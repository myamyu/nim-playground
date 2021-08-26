# nimのmacroにふれる

雑なHTMLマクロを作った。

- Elementとテキストしか対応してない
- ループを組み込んだりできない

```nim
html:
  head:
    title "たいとる"
  body:
    h1 "たいとるだよ"
    main:
      section:
        h2 "せくしょん"
        p:
          "いえっさー"
          br()
          "おいっさー"
```

## 参考

- https://qiita.com/MtShiba/items/b06fff4c4ef98769c781
- https://flat-leon.hatenablog.com/entry/nim_class_macro
- https://flat-leon.hatenablog.com/entry/nim_macro_programming
