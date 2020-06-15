from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.select import Select
import time
import os
import csv
import pymysql
import datetime as dt

#key_sDate = "20200220"
#key_eDate = "20200227"
key_search = "깻잎"
downDir = "D:\_test\\"

def _main(key_sDate, key_eDate):
    # 크롬 드라이버 및 URL 세팅
    options = webdriver.ChromeOptions()
    # options.add_argument('headless')
    # options.add_argument('window-size=1920x1080')
    # options.add_argument("disable-gpu")
    # 혹은 options.add_argument("--disable-gpu")
    options.add_experimental_option("prefs", {"download.default_directory": downDir})
    driver = webdriver.Chrome("D:\chromedriver_win32\chromedriver.exe", options=options)
    driver.implicitly_wait(3)
    driver.get("https://www.garak.co.kr/price/OZViewer.do?R010680=10&R010690=30&R010700=10")  # 가락시장
    # driver.get("https://www.garak.co.kr/price/OZViewer.do?R010680=10&R010690=30&R010700=30") # 강서시장
    #print(driver)

    # 시작일 세팅
    sDate = driver.find_element_by_id("s_date")
    for cnt in range(8):
        sDate.send_keys(Keys.BACKSPACE)
    sDate.send_keys(key_sDate)
    time.sleep(1)

    # 종료일 세팅
    eDate = driver.find_element_by_id("e_date")
    for cnt in range(8):
        eDate.send_keys(Keys.BACKSPACE)
    eDate.send_keys(key_eDate)
    time.sleep(1)

    driver.find_element_by_id('select2-total_search-container').click()
    sKeyword = driver.find_element_by_id("select2_search_input2")
    sKeyword.send_keys(key_search)
    sKeyword.send_keys(Keys.ESCAPE)
    time.sleep(1)

    # 검색 클릭
    # driver.find_element_by_xpath('//*[@id="OZViewer"]/div[1]/input[1]').click()
    btnSearch = driver.find_element_by_xpath('//*[@id="aForm"]/div[1]/div/button[1]')
    driver.execute_script("arguments[0].click();", btnSearch)
    time.sleep(6)

    btnDownload = driver.find_element_by_xpath('/html/body/div[1]/div[2]/div[1]/div[2]/div[2]/div[3]/div[1]/input[1]')
    driver.execute_script("arguments[0].click();", btnDownload)
    # time.sleep(0.5)
    # 파일형식 SelectBox > CSV
    select = Select(driver.find_element_by_xpath('//*[@id="ui-id-3"]/select'))
    select.select_by_index(6)
    """
    # 옵션 > 저장옵션
    driver.find_element_by_xpath('/html/body/div[3]/div[3]/div/button[1]').click() # 옵션
    driver.find_element_by_xpath('//*[@id="ui-id-6"]').click() # 저장옵션
    # 구분자 선택 SelectBox > tab
    select2 = Select(driver.find_element_by_xpath('//*[@id="oztab_id_extra_option"]/table/tr[1]/td/fieldset/table/tr/td[1]/select'))
    select2.select_by_index(0)
    # 인코딩 선택 SelectBox > 유니코드
    select3 = Select(driver.find_element_by_xpath('//*[@id="oztab_id_extra_option"]/table/tr[6]/td/fieldset/table/tr[2]/td/select'))
    select3.select_by_index(1)
    # 저장옵션 > 확인
    driver.find_element_by_xpath('/html/body/div[5]/div[3]/div/button[1]').click()
    """
    # 저장 > 확인
    driver.find_element_by_xpath('/html/body/div[3]/div[3]/div/button[2]').click()
    time.sleep(3)

    _modifyCSV()
    # _renameCSV(downDir, key_sDate + "_" + key_eDate + "_" + key_search)

    """
    //*[@id="aForm"]/div[1]/div/button[1]
    /html/body/div[1]/div[2]/div[1]/div[2]/div[2]/form/div[1]/div/button[1]

    //*[@id="OZViewer"]/div[1]/input[1]
    /html/body/div[1]/div[2]/div[1]/div[2]/div[2]/div[3]/div[1]/input[1]

    //*[@id="ui-id-3"]/select

    /html/body/div[3]/div[3]/div/button[2]
    """

def _modifyCSV():
    newfile = downDir + key_sDate + "_" + key_eDate + "_" + key_search + ".csv"
    catename = ["날짜", "품목", "등급", "거래단위", "최저가", "최고가", "평균가", "전일대비 등락", "전일 평균대비", "전7일 평균대비", "전년동월동일 평균대비"]
    if os._exists(newfile):
        os.remove(newfile)

    with open(newfile, 'w', newline='') as f2:
        wr = csv.writer(f2)
        f1 = open(downDir + "noname.csv", 'r')
        rdr = csv.reader(f1)
        wr.writerow(catename)
        for line in rdr:
            if ("2020." in line[0]) or ("2019." in line[0]) or ("2018." in line[0]) or ("2017." in line[0]):
                #print(line)
                wr.writerow(line)
        f1.close()
    f2.close()

    delfile = downDir + "noname.csv"

    if os.path.exists(delfile):
        os.remove(delfile)

    print("csv 저장완료 - DB적재 시작")
    setDate(newfile)
    print("DB적재 완료")
    time.sleep(20)


def setDate(csvfile):
    conn = pymysql.connect(host='127.0.0.1', user='root', password='1231', db='bms_test', charset='utf8')
    curs = conn.cursor()
    conn.commit()
    print("[1]")
    f = open(csvfile, 'r')
    csvReader = csv.reader(f)
    print("[2]")
    try:
        for row in csvReader:
            csvDate0 = row[0]
            csvDate1 = row[1]
            csvDate2 = row[2]
            csvDate3 = row[3]
            csvDate4 = row[4]
            csvDate5 = row[5]
            csvDate6 = row[6]
            csvDate7 = row[7]
            csvDate8 = row[8]
            csvDate9 = row[9]
            csvDate10 = row[10]

            if "날짜" not in csvDate0:
                sql = """insert into price_seoul_market (DATE, NAME, GRADE, UNIT, PRICE_LOWEST, PRICE_AVG, PRICE_HIGHEST, PRICE_DIFF, PRICE_DIFF_AVG, ETC1, ETC2)
                 values (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)         
                 """
                curs.execute(sql, (csvDate0, csvDate1, csvDate2, csvDate3, csvDate4, csvDate5, csvDate6, csvDate7, csvDate8, csvDate9, csvDate10))
    except Exception as ex:
        print("오류", ex)

    print("[3]")
    # db의 변화 저장
    conn.commit()
    f.close()
    conn.close()


if __name__ == "__main__":
    # create_chrome_option()

    start = dt.datetime(2018, 1, 1)
    end = dt.datetime(2018, 12, 31)

    while(1):
        tmp_end = start + dt.timedelta(days=6)
        if tmp_end > end:
            tmp_end = end
            break
        #print(str(start).replace('-', '')[0:8], str(tmp_end).replace('-', '')[0:8])
        key_sDate = str(start).replace('-', '')[0:8]
        key_eDate = str(tmp_end).replace('-', '')[0:8]

        _main(key_sDate, key_eDate)

        start = tmp_end + dt.timedelta(days=1)

    #setDate(downDir + "20200220_20200227_깻잎.csv")
    #_modifyCSV()


"""
def create_chrome_option():
    # 크롬 드라이버 옵션 설정 
    download_folfer = 'c:\\tmp';
    # download_folfer = "C:\\users\c\Desktop"
    # 브라우저 백그라운드 모드
    options = webdriver.ChromeOptions()

    options.add_experimental_option("prefs", {"download.default_directory": download_folfer,
                                              "download.prompt_for_download": False, "download.directory_upgrade": True,
                                              "safebrowsing_for_trusted_sources_enabled": False,
                                              "safebrowsing.enabled": False})
    options.add_argument('--headless')
    return options

def _renameCSV(filename):
    newfilePath = downDir + key_sDate + "_" + key_eDate + "_" + key_search + ".csv"
    try:
        os.rename(filename, newfilePath)
    except:
        pass
    _modifyCSV(newfilePath)
"""

