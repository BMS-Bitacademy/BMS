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
        setData(soup)
        isExistPage = soup.select("#searchOptionForm > div.search-wrapper > div.search-content.search-content-with-feedback > div.search-pagination")
        if isExistPage != []:
            pageCnt = soup.select("#searchOptionForm > div.search-wrapper > div.search-content.search-content-with-feedback > div.search-pagination > a.btn-last.disabled")[0].text
            #print(pageCnt)
            for i in range(2, int(pageCnt)+1):
                url2 = pageUrl_1 + str(i) + pageUrl_2
                #print(url2)
                html = requests.get(url2, headers=headers)
                soup = BeautifulSoup(html.text, "html.parser")
                #print("[A]========= [ " + str(i) + " ] =========")
                #print(url2)
                if i == 2:
                    print(soup)
                #setData(soup)
                time.sleep(1)


def setData(soup):
    # 리스트 생성
    lst_name = []  # 상품명
    lst_price = []  # 가격
    lst_score = []  # 평균 평점
    lst_count = []  # 판매량
    lst_Link = []  # 상품링크
    lst_imgLink = []  # 상품이미지링크

    lst_product = []

    # 리스트에 담기

    for res in soup.select("a > dl > dd > div > div.name"):
        lst_name.append(res.get_text())

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

    print(lst_name)
    print(lst_price)
    print(lst_score)
    print(lst_count)
    print(lst_Link)
    print(lst_imgLink)

    lst_name.clear()
    lst_price.clear()
    lst_score.clear()
    lst_count.clear()
    lst_Link.clear()
    lst_imgLink.clear()
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


    curs.close()
    conn.close()


if __name__ == "__main__":
    goSearch()