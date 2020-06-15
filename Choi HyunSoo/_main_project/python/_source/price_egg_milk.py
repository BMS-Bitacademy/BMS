from urllib.request import urlopen
from bs4 import BeautifulSoup
import pymysql
import datetime as dt

year = '2020'
period = 2
item = 1    #(1:계란 , 2:우유)

# if period == 1:
#     sMonthDay = '01-01'
#     eMonthDay = '04-30'
# elif period == 2:
#     sMonthDay = '05-01'
#     eMonthDay = '08-31'
# elif period == 3:
#     sMonthDay = '09-01'
#     eMonthDay = '12-31'



def getData(mode):
    # today = dt.datetime.today().strftime('%Y-%m-%d')
    if mode == 1:
        itemcode = '516'
        tablename = 'price_egg'
    elif mode == 2:
        itemcode = '535'
        tablename = 'price_milk'

    # yesterday = '2020-06-03'
    yesterday = (dt.datetime.today() - dt.timedelta(1)).strftime('%Y%m%d')

    # url = "https://www.kamis.or.kr/customer/price/product/period.do?action=daily&startday="\
    #       + year + "-" + sMonthDay + "&endday=" + year + "-" + eMonthDay + \
    #       "&countycode=&itemcategorycode=500&itemcode=" + itemcode + "&kindcode=00&productrankcode=0&convert_kg_yn=N"
    url = "https://www.kamis.or.kr/customer/price/product/period.do?action=daily&startday=" \
          + yesterday + "&endday=" + yesterday + \
          "&countycode=&itemcategorycode=500&itemcode=" + itemcode + "&kindcode=00&productrankcode=0&convert_kg_yn=N"

    print(url)
    html = urlopen(url)
    soup = BeautifulSoup(html, "html.parser", from_encoding="cp949")
    soup2 = soup.find("table", class_="wtable3")

    lst_date = []
    lst_price = []

    soup_date = soup2.select('tr')[0]
    for i in range(1, 90):
        try:
            lst_date.append(year + '-' + soup_date.select('th')[i].text.replace('/', '-'))
        except:
            pass
    soup_price = soup2.select('tr')[1]

    for i in range(1, 90):
        try:
            lst_price.append(soup_price.select('td')[i].text)
        except:
            pass
    setDBData(lst_date, lst_price, tablename)


def setDBData(lst_date, lst_price, tablename):
    conn = pymysql.connect(host="localhost", user="root", password="1231", db="bms_test", charset="utf8")
    curs = conn.cursor()

    sql = "INSERT INTO " + tablename + "(date, price) VALUES (%s, %s)"

    for i in range(0, len(lst_date)):
        try:
            curs.execute(sql, (lst_date[i], lst_price[i]))
        except Exception as e:
            print(e)
            pass

    conn.commit()
    curs.close()
    conn.close()


if __name__ == "__main__":
    for i in range(1, 3):
        getData(i)
