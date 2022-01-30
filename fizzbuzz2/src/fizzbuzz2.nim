import parseutils, strutils, tables
from math import gcd

proc `$`(n: int): string =
  ## 数値を文字列にするときにFizzBuzzをかける
  const tbl = {3: "Fizz", 5: "Buzz", 15: "FizzBuzz"}.toTable()
  let v = n.gcd(15)
  return if v in tbl: tbl[v] else: strutils.intToStr(n)

when isMainModule:
  echo "number:"
  let input = stdin.readLine
  var num: int
  discard input.parseInt(num, 0)
  for i in 1..num:
    echo $i
