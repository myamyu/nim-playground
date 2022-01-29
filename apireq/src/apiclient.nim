import httpclient, uri, parsexml, streams

type APIError* = object of CatchableError

#[
  XMLのElementからテキストを抽出
]#
proc extractText(x: var XmlParser): string =
  result = ""
  if x.kind == xmlElementStart:
    x.next()
  while x.kind == xmlCharData:
    result.add(x.charData)
    x.next()

type YahooTextAPIClient* = ref object
  appID*: string

#[
  テキストAPIのクライアントを生成
]#
proc newYahooTextAPIClient*(appID: string): YahooTextAPIClient =
  return YahooTextAPIClient(appID: appID)

#[
  かな漢字変換のセグメント
]#
type ConversionSegment* = object
  segmentText*: string
  candidate*: seq[string]

#[
  かな漢字変換のレスポンス
]#
type RespConversion* = object
  segmentList*: seq[ConversionSegment]

#[
  かな漢字変換
  https://developer.yahoo.co.jp/webapi/jlp/jim/v1/conversion.html
]#
proc conversion*(c: YahooTextAPIClient, sentence: string): RespConversion =
  const endpoint = "https://jlp.yahooapis.jp/JIMService/V1/conversion"
  let url = endpoint & "?" & encodeQuery({
    "appid": c.appID,
    "sentence": sentence,
  })

  let req = newHttpClient()
  let resp = req.get(url)
  if resp.code() != Http200:
    # 200じゃない場合はなにか出てる
    raise newException(APIError, "API Response: " & resp.status)

  # xmlを解析
  result = RespConversion()
  var strm = newStringStream(resp.body)
  var x: XmlParser
  open(x, strm, endpoint)
  defer: x.close()
  while true:
    case x.kind
    of xmlElementStart:
      case x.elementName
      of "Segment":
        # Segment要素の場合は中身を詰める準備
        result.segmentList.add(ConversionSegment())
        x.next()
      of "SegmentText":
        # SegmentTextの内容を詰める
        let text = extractText(x)
        result.segmentList[^1].segmentText = text
      of "Candidate":
        # Candidateの内容を追加
        let text = extractText(x)
        result.segmentList[^1].candidate.add(text)
      else:
        x.next()
    of xmlEof:
      break
    else:
      x.next()
