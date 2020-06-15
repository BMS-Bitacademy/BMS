from selenium import webdriver
from selenium.webdriver.support.select import Select
import time
import csv
import pymysql
import os
import datetime as dt

yesterday = (dt.datetime.today() - dt.timedelta(1)).strftime('%Y%m%d')
# key_sDate = yesterday
# key_eDate = yesterday

key_sDate = "20200605"
key_eDate = "20200610"
lst_y = ['2008', '2009', '2010', '2011', '2012', '2013', '2014', '2015', '2016', '2017', '2018', '2019', '2020']
downDir = 'D:\_test\\'

# 크롬 드라이버 및 URL 세팅
options = webdriver.ChromeOptions()
options.add_experimental_option('prefs', {'download.default_directory': downDir})
driver = webdriver.Chrome('D:\chromedriver_win32\chromedriver.exe', options=options)
driver.implicitly_wait(3)
driver.get('http://www.opinet.co.kr/glopcoilSelect.do')
#print(driver)

# 시작일 세팅
s_Y = Select(driver.find_element_by_xpath('//*[@id="STA_Y"]'))
s_Y.select_by_index(lst_y.index(key_sDate[0:4]))
s_M = Select(driver.find_element_by_xpath('//*[@id="STA_M"]'))
s_M.select_by_index(int(key_sDate[4:6])-1)
s_D = Select(driver.find_element_by_xpath('//*[@id="STA_D"]'))
s_D.select_by_index(int(key_sDate[6:8])-1)
# 종료일 세팅
e_Y = Select(driver.find_element_by_xpath('//*[@id="END_Y"]'))
e_Y.select_by_index(lst_y.index(key_eDate[0:4]))
e_M = Select(driver.find_element_by_xpath('//*[@id="END_M"]'))
e_M.select_by_index(int(key_eDate[4:6])-1)
e_D = Select(driver.find_element_by_xpath('//*[@id="END_D"]'))
e_D.select_by_index(int(key_eDate[6:8])-1)
# 세팅한 기간에 대한 데이터 검색
btnSearch = driver.find_element_by_xpath('//*[@id="glopcoilSelect"]')
driver.execute_script("arguments[0].click();", btnSearch)
time.sleep(3)
# 검색 결과 csv저장버튼 클릭
btnDowncsv = driver.find_element_by_xpath('//*[@id="glopcoil_csv"]')
driver.execute_script("arguments[0].click();", btnDowncsv)
time.sleep(3)

# DB 연결 및 csv파일 읽기 -> csv 데이터를 DB에 저장
conn = pymysql.connect(host='127.0.0.1', user='root', password='1231', db='bms_test', charset='utf8')
curs = conn.cursor()
conn.commit()

f = open(downDir + '국제_원유가격' + str(key_sDate) + '_' + str(key_eDate) + '.csv', 'r')
csvReader = csv.reader(f)

try:
    for row in csvReader:
        if not row[0] == '기간':
            sql = 'INSERT INTO price_oil VALUES (%s, %s, %s, %s)'
            try:
                curs.execute(sql, ('20' + row[0].replace('년', '-').replace('월', '-').replace('일', ''), row[1], row[2], row[3]))
            except Exception as e:
                print('except:', e)
except Exception as ex:
    print("오류", ex)

conn.commit()
f.close()
conn.close()

# DB 저장 후 csv파일삭제
try:
    os.remove(downDir + '국제_원유가격' + str(key_sDate) + '_' + str(key_eDate) + '.csv')
except:
    print('파일 삭제 실패')
