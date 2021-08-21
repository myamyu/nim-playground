discard """

action: "run"

"""

import "../src/nim_de_test"

block sum:
  doAssert 1.sum(10) == 11, "足し算が間違ってる"
  doAssert 123.sum(321) == 444, "足し算が間違ってる"
