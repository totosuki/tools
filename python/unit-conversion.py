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

def insert_comma(num):
  num = int(num)
  return "{:,}".format(num)

def main():
  print("単位変換を行います。")
  print("例 : 1 million を 1000000 に変換します。")
  while True:
    num, unit = input("変換する単位 : ").split()
    if unit in dict:
      num = float(num) * dict[unit]
      print(f"桁区切り : {insert_comma(num)}")
      print(f"指数表記 : {num:.3e}\n です")
    else:
      print("その単位は存在しません。")
    if input("続けますか？(y/n) : ") == "n":
      break

if __name__ == "__main__":
  main()