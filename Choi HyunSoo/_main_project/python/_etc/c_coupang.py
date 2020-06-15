import time
#from builtins import print
import requests
from bs4 import BeautifulSoup
import pymysql

# searchKeyword = "%EB%AC%BC"
# url = "https://www.coupang.com/np/search?component=&q=%EB%AC%BC&channel=user&"
# 크롤링 - 대상 및 키워드 설정
searchKeyword = "물"
#searchKeyword = "당근"
#searchKeyword = "ㅁㄴㅇㅁㄴㅇ"
#searchKeyword = "최현수"
SITE = "https://www.coupang.com"
maxCnt = 72  # 한 페이지에 볼 수 있는 상품의 최대 개수(쿠팡)

# 크롤링 - url 세팅
url = SITE + "/np/search?component=&q=" + searchKeyword + "&channel=user&listSize=" + str(maxCnt)
pageUrl_1 = url + "&component=&eventCategory=SRP&trcid=&traid=&sorter=scoreDesc&minPrice=&maxPrice=&priceRange=" \
                "&filterType=&filter=&isPriceRange=false&brand=&offerCondition=&rating=0&page="
pageUrl_2 = "&rocketAll=false&searchIndexingToken=1=1&backgroundColor="

def goSearch():
    # 크롤링 - 실행부(403 에러로 인해 헤더 추가)
    headers = {'User-Agent': 'Mozilla/5.0'}
    html = requests.get(url, headers=headers)
    soup = BeautifulSoup(html.text, "html.parser")
    #print(soup)

    # 검색 결과 유무 확인
    isExistResult = soup.select("#searchOptionForm > div.search-wrapper > div.search-content.search-content-with-feedback > div.search-query-result > p")[0]["class"]
    # print(isExistResult)
    if isExistResult[0] == "no-item":
        print("검색 결과 없음")
    else:
        print("검색 결과 있음")
        setData(soup, 1)
        isExistPage = soup.select("#searchOptionForm > div.search-wrapper > div.search-content.search-content-with-feedback > div.search-pagination")
        if isExistPage != []:
            pageCnt = soup.select("#searchOptionForm > div.search-wrapper > div.search-content.search-content-with-feedback > div.search-pagination > a.btn-last.disabled")[0].text
            #print(pageCnt)
            for i in range(2, int(pageCnt)+1):
                url2 = pageUrl_1 + str(i) + pageUrl_2
                html = requests.get(url2, headers=headers)
                soup = BeautifulSoup(html.text, "html.parser")
                #print("[A]========= [ " + str(i) + " ] =========")
                #print(url2)
                setData(soup, i)
                time.sleep(1)


def setData(soup, page):
    # DB 연결 및 적재
    conn = pymysql.connect(host="localhost", user="root", password="1231", db="bms_test", charset="utf8")
    curs = conn.cursor()
    sql = "INSERT INTO b_coupang(SITE, SEARCH_KEYWORD, PRODUCT_NAME, PRICE, SCORE, SELL_COUNT, LINK, IMG_LINK)" \
          "VALUES (%s, %s, %s, %s, %s, %s, %s, %s)"

    lst_product = []

    print(page)

    for i in range(maxCnt):
        try:
            soup2 = soup.select("li.search-product")[i]
            lst_product.append(soup2.find("div", class_="name").text)
            lst_product.append(soup2.find("strong", class_="price-value").text)
            lst_product.append(soup2.find("em", class_="rating").text)
            lst_product.append(soup2.find("span", class_="rating-total-count").text[1:-1])
            lst_product.append(soup2.find("a", class_="search-product-link").get("href"))
            lst_product.append(soup2.find("img", class_="search-product-wrap-img").get("data-img-src"))

            if len(lst_product) == 6:
                try:
                    curs.execute(sql, (SITE, searchKeyword,
                                       lst_product[0], lst_product[1], lst_product[2], lst_product[3], lst_product[4], lst_product[5]))
                except Exception as e:
                    print(e)
        except Exception as e:
            #pass
            print(str(page) + "-" + str(i) + " " + str(lst_product))
            print(e)

        #print("["+ str(i) +"] " + str(len(lst_product)) + "개 " + str(lst_product))
        lst_product.clear()
    conn.commit()
    curs.close()
    conn.close()


if __name__ == "__main__":
    goSearch()