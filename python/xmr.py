import requests
from bs4 import BeautifulSoup

ADDRESS = "46PG5MGnkQKZJH9QCYdYW8gHUw5sdRMwq7EboAim2QeF578DBKt1gSTS8GhAxczJLPHgkohDZMQwjDQMbSzHvYqjGCR9gXh"


def print_balance():
    url = f"https://api.nanopool.org/v1/xmr/balance/{ADDRESS}"
    res = requests.get(url)
    balance = float(res.json()["data"])
    
    url = f"https://coinmarketcap.com/ja/currencies/monero/"
    res = requests.get(url)
    soup = BeautifulSoup(res.text, "html.parser")
    elems = soup.select("#section-coin-overview > div.sc-d1ede7e3-0.gNSoet.flexStart.alignBaseline > span")
    xmr_yen = float(elems[0].text.translate(str.maketrans({"¥":"",",":""})))
    
    print(f"現在のXMR残高は、{balance * xmr_yen:.2f}円です。")

def print_hashrate():
    hour = int(input("取得したい平均ハッシュレート："))
    url = f"https://api.nanopool.org/v1/xmr/avghashratelimited/{ADDRESS}/{hour}"
    res = requests.get(url)
    data = res.json()["data"]
    print(f"{hour}時間の平均ハッシュレートは、{data:.2f}H/sです。")

def main():
    print_balance()
    print_hashrate()

main()