import os
from strutils import join
import ./apiclient

const APP_ID = getEnv("YAHOO_APP_ID")

proc convKanji(kana: string) =
  let cli = newYahooTextAPIClient(APP_ID)
  let resp = cli.conversion(kana)
  echo "input: ", kana
  echo "↓"
  for seg in resp.segmentList:
    echo seg.segmentText, ": ", seg.candidate.join(", ")

when isMainModule:
  convKanji("にわにはにわにわとりがいる。")
