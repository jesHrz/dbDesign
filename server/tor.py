import tornado.web
from sqlHandler import *
import tornado.web

from sqlHandler import *


class loginHandler():

    def login(self, username, pwd):
        sql = f"select pwd from login where sid = {username}"
        self.cursor.execute(sql)
        rr = self.cursor.fetchall()
        print(rr[0][0])
        if pwd == rr[0][0]:
            sql = f"select name from person where sid = {username}"
            self.cursor.execute(sql)
            rr = self.cursor.fetchall()
            return rr[0][0]
        else:
            return ""

class mainHandler(tornado.web.RequestHandler):
    #service = login()

    def post(self):
        self.set_header('Access-Control-Allow-Origin', '*')
        username = self.get_argument('usr')
        pwd = self.get_argument('pwd')
        res = self.service.login(username, pwd)
        if res != "":
            print(res, "login")
            self.write("Welcome, " + res)
        else:
            self.write("login failed")

if __name__ == '__main__':
    """app = tornado.web.Application([(r"/login/", mainHandler), ])
    port = 29888
    app.listen(port)
    print("Running on port", port)
    tornado.ioloop.IOLoop.current().start()"""
    mysql = sqlHandler("tornado", "tornado", "dbDesign", "139.196.96.35")
    print(mysql.select("select pwd from login"))
    print(mysql.select("select * from login"))