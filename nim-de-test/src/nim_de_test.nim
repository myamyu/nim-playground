
proc sum*(a:int, b:int):int =
  result = a + b

when isMainModule:
  echo 1.sum(10)
  echo sum(2, 15)
