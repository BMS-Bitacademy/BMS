from urllib.request import urlopen
from bs4 import BeautifulSoup
import pymysql
import datetime as dt


def getData(page):
    #url = "https://www.atfis.or.kr/basicprice/M002010000/itemView.do?uniqId=0701000002011303"
    url = 'https://www.atfis.or.kr/basicprice/M002010000/itemView.do?page=' + str(page) + '&uniqId=0701000002011303&type=&searchStartDate=&searchEndDate='
    html = urlopen(url)
    soup = BeautifulSoup(html, "html.parser", from_encoding="cp949").find('table', summary='일일 가격 목록')
    lst_data = []
    yesterday = (dt.datetime.today() - dt.timedelta(1)).strftime('%Y-%m-%d')

    # for i in range(1, 21):
    for i in range(1, 2):
        soup2 = soup.select('tr')[i]
        for res in soup2.find_all("td"):
            lst_data.append(res.get_text().replace("\n", "").replace("\t", "").replace("\r", ""))
        print(lst_data)
        # if (lst_data[1] == yesterday):
        if True:
            setDBData(lst_data)
        lst_data.clear()

    print("{} 페이지 DB입력 완료".format(page))


def setDBData(lst_data):
    conn = pymysql.connect(host="localhost", user="root", password="1231", db="bms_test", charset="utf8")
    curs = conn.cursor()

    sql = "INSERT INTO price_sugar (date, price_closing, difference, rate_UpDown) VALUES (%s, %s, %s, %s)"

    try:
        curs.execute(sql, (lst_data[1], lst_data[2], lst_data[3], lst_data[4]))
    except Exception as e:
        print(e)
        pass

    conn.commit()
    curs.close()
    conn.close()


if __name__ == "__main__":
    # for i in range(90, 0, -1):
    #     getData(i)
    getData(1)
