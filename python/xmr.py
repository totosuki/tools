import requests
from bs4 import BeautifulSoup

ADDRESS = "46PG5MGnkQKZJH9QCYdYW8gHUw5sdRMwq7EboAim2QeF578DBKt1gSTS8GhAxczJLPHgkohDZMQwjDQMbSzHvYqjGCR9gXh"
URL1 = f"https://api.nanopool.org/v1/xmr/balance/{ADDRESS}"
URL2 = f"https://coinmarketcap.com/ja/currencies/monero/"

res1 = requests.get(URL1)
res2 = requests.get(URL2)
soup = BeautifulSoup(res2.text, "html.parser")
elems = soup.select("#section-coin-overview > div.sc-d1ede7e3-0.gNSoet.flexStart.alignBaseline > span")

balance = float(res1.json()["data"])
xmr_yen = float(elems[0].text.translate(str.maketrans({"¥":"",",":""})))

print(f"現在のXMR残高は、{balance * xmr_yen:.2f}円です。")