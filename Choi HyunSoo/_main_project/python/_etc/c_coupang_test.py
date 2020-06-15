import time
#from builtins import print
import requests
from bs4 import BeautifulSoup
import pymysql

# searchKeyword = "%EB%AC%BC"
# url = "https://www.coupang.com/np/search?component=&q=%EB%AC%BC&channel=user&"
# 크롤링 - 대상 및 키워드 설정
searchKeyword = "물"
SITE = "https://www.coupang.com"
maxCnt = 72  # 한 페이지에 볼 수 있는 상품의 최대 개수(쿠팡)

# 크롤링 - url 세팅
url = SITE + "/np/search?component=&q=" + searchKeyword + "&channel=user&listSize=" + str(maxCnt)
pageUrl_1 = url + "&component=&eventCategory=SRP&trcid=&traid=&sorter=scoreDesc&minPrice=&maxPrice=&priceRange=" \
                "&filterType=&filter=&isPriceRange=false&brand=&offerCondition=&rating=0&page="
pageUrl_2 = "&rocketAll=false&searchIndexingToken=1=1&backgroundColor="
url2 = pageUrl_1 + str(2) + pageUrl_2


def goSearch():
    # 크롤링 - 실행부(403 에러로 인해 헤더 추가)
    headers = {'User-Agent': 'Mozilla/5.0'}
    html = requests.get(url2, headers=headers)
    soup = BeautifulSoup(html.text, "html.parser")
    setData(soup)

def setData(soup):
    lst_product = []

    for i in range(maxCnt):
        try:
            soup2 = soup.select("li.search-product")[i]
            lst_product.append(soup2.find("div", class_="name").text)
            lst_product.append(soup2.find("strong", class_="price-value").text)
            lst_product.append(soup2.find("em", class_="rating").text)
            lst_product.append(soup2.find("span", class_="rating-total-count").text[1:-1])
            lst_product.append(soup2.find("a", class_="search-product-link").get("href"))
            lst_product.append(soup2.find("img", class_="search-product-wrap-img").get("data-img-src"))
        except:
            pass

        #print("["+ str(i) +"] " + str(len(lst_product)) + "개 " + str(lst_product))
        lst_product.clear()

"""
    for res in soup.select("a > dl > dd > div > div.price-area > div:price-wrap > div.price > em > strong"):
        lst_price.append(res.get_text())

    for res in soup.select("a > dl > dd > div > div.other-info > div > span.star > em"):
        lst_score.append(res.get_text())

    for res in soup.select("a > dl > dd > div > div.other-info > div > span.rating-total-count"):
        lst_count.append(res.get_text()[1:len(res.get_text()) - 1])

    for res in soup.select("li.search-product > a"):
        lst_Link.append(res.get("href"))

    for res in soup.select("li.search-product > a > dl > dt > img"):
        lst_imgLink.append(res.get("data-img-src"))
"""
    #lst_name.clear()
    #lst_price.clear()
    #lst_score.clear()
    #lst_count.clear()
    #lst_Link.clear()
    #lst_imgLink.clear()
"""
    # DB 연결 및 적재
    conn = pymysql.connect(host="localhost", user="root", password="1231", db="bms_test", charset="utf8")
    curs = conn.cursor()

    sql = "INSERT INTO b_coupang(SITE, SEARCH_KEYWORD, PRODUCT_NAME, PRICE, SCORE, SELL_COUNT, LINK, IMG_LINK)" \
          "VALUES (%s, %s, %s, %s, %s, %s, %s, %s)"

    for i in range(maxCnt):
        try:
            print("[B]========= [ " + str(i) + " ] =========")
            curs.execute(sql, (SITE, searchKeyword, lst_name[i], lst_price[i], lst_score[i], lst_count[i], lst_Link[i],
                               lst_imgLink[i]))

        except Exception as ex:
            print(ex)
    conn.commit()
"""


if __name__ == "__main__":
    goSearch()