dict = {
  "thousand" : 1e3,
  "million" :  1e6,
  "billion" :  1e9,
  "trillion" : 1e12,
  "quadrillion" : 1e15,
  "quintillion" : 1e18,
  "sextillion" : 1e21,
  "septillion" : 1e24,
  "octillion" : 1e27,
  "nonillion" : 1e30,
  "decillion" : 1e33,
  "undecillion" : 1e36,
  "duodecillion" : 1e39,
  "tredecillion" : 1e42,
  "quattuordecillion" : 1e45,
  "quindecillion" : 1e48,
  "sexdecillion" : 1e51,
  "septendecillion" : 1e54,
  "octodecillion" : 1e57,
  "novemdecillion" : 1e60,
  "vigintillion" : 1e63,
  "unvigintillion" : 1e66,
  "duovigintillion" : 1e69,
  "tresvigintillion" : 1e72
}

jp_dict = {
  1e4 : "万",
  1e8 : "億",
  1e12 : "兆",
  1e16 : "京",
  1e20 : "垓",
  1e24 : "𥝱",
  1e28 : "穣",
  1e32 : "溝",
  1e36 : "澗",
  1e40 : "正",
  1e44 : "載",
  1e48 : "極",
  1e52 : "恒河沙",
  1e56 : "阿僧祇",
  1e60 : "那由他",
  1e64 : "不可思議",
  1e68 : "無量大数",
}

def insert_comma(num):
  num = int(num)
  return "{:,}".format(num)

def convert_jp(num):
  num = int(num)
  for key in jp_dict:
    if num < key * 1000:
      return f"{num / key:.3f}{jp_dict[key]}"

def main():
  print("単位変換を行います。")
  print("例 : 1 million を 1000000 に変換します。")
  while True:
    num, unit = input("変換する単位 : ").split()
    if unit in dict:
      num = float(num) * dict[unit]
      print(f"桁区切り : {insert_comma(num)}")
      print(f"指数表記 : {num:.3e}\n です")
      print(f"日本語表記 : {convert_jp(num)}")
    else:
      print("その単位は存在しません。")
    if input("続けますか？(y/n) : ") == "n":
      break

if __name__ == "__main__":
  main()