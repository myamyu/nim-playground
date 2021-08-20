import strutils
import tables
from math import gcd

#[
  基本的なFizzBuzz
]#
proc fizzbuzz(num:int):seq[string] =
  result = @[]
  for i in 1..num:
    var item:string = ""
    if i mod 3 == 0: 
      item = "Fizz"
    if i mod 5 == 0:
      item &= "Buzz"
    if item == "":
      item = $i
    result.add(item)

#[
  15との最大公約数が3,5,15のときに変換するやり方
  参考：https://ja.wikipedia.org/wiki/Fizz_Buzz
]#
proc fizzbuzz2(num:int):seq[string] =
  let tbl = {3:"Fizz", 5:"Buzz", 15:"FizzBuzz"}.toTable()
  result = @[]
  for i in 1..num:
    let v = i.gcd(15)
    result.add(if v in tbl: tbl[v] else: $i)

# 文字列がintにparseできるかどうか
proc isInt(s:string):bool =
  try:
    discard s.parseInt()
    result = true
  except:
    discard

when isMainModule:
  echo "number:"
  var input = stdin.readLine
  var num:int = if input.isInt(): input.parseInt() else: 100
  # 基本的なやつ
  var fb = num.fizzbuzz()
  echo "basic logic:"
  echo fb.join(",")
  # トリッキーなやつ
  fb = num.fizzbuzz2()
  echo ""
  echo "tricky logic:"
  echo fb.join(",")
