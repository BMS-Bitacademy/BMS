from builtins import print
from urllib.request import urlopen
from bs4 import BeautifulSoup
import pymysql


def getMovieScore(page):
    # html = urlopen("https://movie.naver.com/movie/point/af/list.nhn")
    conn = pymysql.connect(host="localhost", user="root", password="1231", db="movie_test", charset="utf8")
    curs = conn.cursor()


    try:
        for i in range(page, 0, -1):
            html = urlopen("https://movie.naver.com/movie/point/af/list.nhn?&page=" + str(i))
            aa = BeautifulSoup(html, "html.parser", from_encoding="cp949")

            print(aa)

            lst_num = []
            lst_title = []
            lst_score = []
            lst_name = []

            for res in aa.select("td.num.ac"):
                lst_num.append(res.get_text())
                #print(res.get_text())

            for res in aa.select("a.color_b.movie"):
                lst_title.append(res.get_text())
                #print(res.get_text())

            for res in aa.select("td.num > a.author"):
                lst_name.append(res.get_text())
                #print(res.get_text())

            for res in aa.select("div.list_netizen_score > em"):
                lst_score.append(res.get_text())
                #print(res.get_text())

            sql = "INSERT INTO m_score (num, title, score, name) VALUES (%s, %s, %s, %s)"

            for i in range(10):
                try:
                    curs.execute(sql, (lst_num[i], lst_title[i], lst_score[i], lst_name[i]))
                except:
                    pass
            conn.commit()

            lst_num.clear()
            lst_title.clear()
            lst_score.clear()
            lst_name.clear()
    except:
        pass
    finally:
        try:
            sql = "call setName2"
            curs.execute(sql)
            conn.commit()
        except:
            pass
        finally:
            curs.close()
            conn.close()


if __name__ == "__main__":
    getMovieScore(5)
    # getMovieScore()
