from builtins import print
from urllib.request import urlopen
from bs4 import BeautifulSoup
import pymysql
import datetime as dt


def getData(company_name, company_code, page):
    url = "https://finance.naver.com/item/sise_day.nhn?code=" + company_code + "&page=" + page
    html = urlopen(url)

    soup = BeautifulSoup(html, "html.parser", from_encoding="cp949")
    lst_data = []
    # lst_num = [2, 3, 4, 5, 6, 10, 11, 12, 13, 14]
    lst_num = [14, 13, 12, 11, 10, 6, 5, 4, 3, 2]

    for i in lst_num:
        soup2 = soup.select("tr")[i]
        dateCheck = soup2.find(align="center").text
        # print(dateCheck)
        if dateCheck == dt.datetime.today().strftime('%Y.%m.%d'):   # 배치 돌릴시 사용
        # if dateCheck == '2020.06.09':                             # 특정 날짜 데이터 수집시 사용
        # if True:                                                  # 전체 데이터 수집시 사용
            # print('aaaa')
            lst_data.extend([company_name, company_code])
            lst_data.append(dateCheck)
            soup2.find(align="center").text
            for res in soup2.find_all("td", class_="num"):
                lst_data.append(res.get_text().replace("\n", "").replace("\t", ""))

            try:
                status = soup2.find("img").get("src").replace("https://ssl.pstatic.net/imgstock/images/images4/ico_",
                                                              "").replace(".gif", "")
            except:
                status = ''

            if status == 'up':
                lst_data.append('▲')
            elif status == 'up02':
                lst_data.append('▲▲')
            elif status == 'down':
                lst_data.append('▼')
            elif status == 'down02':
                lst_data.append('▼▼')
            else:
                lst_data.append('')
            #
            # try:
            #     lst_data.append(soup2.find("img").get("src").replace("https://ssl.pstatic.net/imgstock/images/images4/ico_", "").replace(".gif", ""))
            # except:
            #     lst_data.append("")

            setDBData(lst_data)
            lst_data.clear()

    print("{} {} 페이지 완료".format(company_name, page))


def setDBData(lst_data):
    conn = pymysql.connect(host="localhost", user="root", password="1231", db="bms_test", charset="utf8")
    curs = conn.cursor()
    print(lst_data)
    sql = "INSERT INTO stock_day (com_name, com_code, date, price_closing, difference, price_market, price_high, price_low, volume, status)" \
          " VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"

    try:
        curs.execute(sql,
                     (lst_data[0], lst_data[1], lst_data[2], lst_data[3].replace(',', ''), lst_data[4].replace(',', '')
                      , lst_data[5].replace(',', ''), lst_data[6].replace(',', ''), lst_data[7].replace(',', '')
                      , lst_data[8].replace(',', ''), lst_data[9]))
    except Exception as e:
        # print(sql)
        print(e)
        pass

    conn.commit()
    curs.close()
    conn.close()


def init(code, name):
    ## 회사명 및 코드 입력
    com_info = [code, name]

    url = "https://finance.naver.com/item/sise_day.nhn?code=" + com_info[0]
    html = urlopen(url)
    soup = BeautifulSoup(html, "html.parser", from_encoding="cp949")
    last_page = soup.find("td", class_="pgRR").find("a")["href"].replace(
        "/item/sise_day.nhn?code=" + com_info[0] + "&page=", "")

    # 아래 주석해야 전체 기간의 데이터 수집
    last_page = 1

    for i in range(int(last_page), 0, -1):
        getData(com_info[1], com_info[0], str(i))


if __name__ == "__main__":
    # html = urlopen("https://finance.naver.com/item/sise.nhn?code=001550") # 조비
    # html = urlopen("https://finance.naver.com/item/sise_day.nhn?code=154030&page=121")
    """
    "001550", "조비"
    "097870", "효성오앤비"
    "154030", "아시아종묘"   
    "025860", "남해화학"
    "002100", "경농"
    "001390", "KG케미칼"
    "054050", "농우바이오"
    "290380", "대유"
    "003080", "성보화학"
    "050860", "아세아텍"
    "007590", "동방아그로"
    "114450", "KPX생명과학"
    "005610", "SPC삼립"
    "017810", "풀무원"
    """

    lst_com = [["001550", "조비"]
               , ["097870", "효성오앤비"]
               , ["154030", "아시아종묘"]
               , ["025860", "남해화학"]
               , ["002100", "경농"]
               , ["001390", "KG케미칼"]
               , ["054050", "농우바이오"]
               , ["290380", "대유"]
               , ["003080", "성보화학"]
               , ["050860", "아세아텍"]
               , ["007590", "동방아그로"]
               , ["114450", "KPX생명과학"]
               , ["005610", "SPC삼립"]
               , ["017810", "풀무원"]
               , ["004370", "농심"]
               , ["007310", "오뚜기"]
               , ["271560", "오리온"]
               , ["280360", "롯데제과"]
               , ["101530", "해태제과"]
               , ["006380", "카프로"]
               , ["000490", "대동공업"]
               , ["004410", "서울식품"]
               , ["003920", "남양유업"]
               , ["001790", "대한제당"]
               , ["002600", "조흥"]
               , ["005180", "빙그레"]
               , ["002270", "롯데푸드"]
               , ["097950", "CJ제일제당"]
               , ["003230", "삼양식품"]
               , ["005990", "매일홀딩스"]
               , ["026960", "동서"]
               , ["005670", "푸드웰"]
               ]
    for code, name in lst_com:
        init(code, name)
