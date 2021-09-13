import strutils, tables
from math import gcd

proc `$`(n: int): string =
  ## 数値を文字列にするときにFizzBuzzをかける
  const tbl = {3:"Fizz", 5:"Buzz", 15:"FizzBuzz"}.toTable()
  let v = n.gcd(15)
  return if v in tbl: tbl[v] else: strutils.intToStr(n)

proc isInt(s: string): bool =
  ## 文字列がintにparseできるかどうか
  try:
    discard s.parseInt()
    result = true
  except:
    discard

when isMainModule:
  echo "number:"
  let input = stdin.readLine
  let num: int = if input.isInt(): input.parseInt() else: 100
  for i in 1..num:
    echo $i
