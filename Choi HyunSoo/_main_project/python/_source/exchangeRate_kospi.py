import requests
from bs4 import BeautifulSoup
import pymysql
import sys

def getData(mode, cnt):
    headers = {'User-Agent': 'Mozilla/5.0'}
    url = 'https://kr.investing.com/currencies/usd-krw-historical-data'
    if mode == 1:
        url = 'https://kr.investing.com/indices/kospi-historical-data'
    res = requests.get(url, headers=headers)
    soup = BeautifulSoup(res.text, 'html.parser')
    #print(soup)
    lst_data = []
    soup2 = soup.find('table', class_='genTbl closedTbl historicalTbl')

    for i in range(cnt, 0, -1):
        soup3 = soup2.find_all_next('tr')[i]
        lst_data.append(soup3.select('td')[0].text.replace('년 ', '-').replace('월 ', '-').replace('일', ''))
        lst_data.append(soup3.select('td')[1].text)
        lst_data.append(soup3.select('td')[2].text)
        lst_data.append(soup3.select('td')[3].text)
        lst_data.append(soup3.select('td')[4].text)
        lst_data.append(soup3.select('td')[5].text)
        if mode == 1:
            lst_data.append(soup3.select('td')[6].text)
        print(lst_data)
        setDBData(mode, lst_data)
        lst_data.clear()



def setDBData(mode, lst_data):
    conn = pymysql.connect(host="localhost", user="root", password="1231", db="bms_test", charset="utf8")
    curs = conn.cursor()

    sql = "INSERT INTO exchangeRate (date, price_closing, price_opening, price_high, price_low, difference) VALUES" \
          " (%s, %s, %s, %s, %s, %s) ON DUPLICATE KEY UPDATE price_closing=%s, price_high=%s, price_low=%s, difference=%s"
    if mode == 1:
        sql = "INSERT INTO kospi (date, price_closing, price_opening, price_high, price_low, volume, difference) VALUES" \
              " (%s, %s, %s, %s, %s, %s, %s) ON DUPLICATE KEY UPDATE price_closing=%s, price_high=%s, price_low=%s, volume=%s, difference=%s"

    try:
        if mode == 0:
            curs.execute(sql, (lst_data[0], lst_data[1], lst_data[2], lst_data[3], lst_data[4], lst_data[5],
                               lst_data[1], lst_data[3], lst_data[4], lst_data[5]))
        elif mode == 1:
            curs.execute(sql, (lst_data[0], lst_data[1], lst_data[2], lst_data[3], lst_data[4], lst_data[5], lst_data[6],
                               lst_data[1], lst_data[3], lst_data[4], lst_data[5], lst_data[6]))
        print("{} 자 DB입력 완료".format(lst_data[0]))

    except Exception as e:
        print(e)
        print("{} 자 DB입력 실패".format(lst_data[0]))
        pass

    conn.commit()
    curs.close()
    conn.close()

if __name__ == '__main__':
    # mode = sys.argv[1]
    # mode = 1    # 0:환율  1:코스피

    cnt = 2  # 금일 기준으로 수집하고자 하는 날짜 수
    for i in range(2):
        getData(i, cnt)