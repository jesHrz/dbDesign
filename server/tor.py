import json

import tornado.ioloop
import tornado.web
import tornado.options

from config import *
from sqlHandler import *

tornado.options.define("port", default=8080, type=int, help="run server on the given port.") # 定义服务器监听端口选项

class registerHandler(tornado.web.RedirectHandler):
    def initialize(self):
        self.handler = sqlHandler(dbUsername, dbPassword, dbDatabase, dbHost, dbPort)

    def set_default_headers(self):
        self.set_header("Access-Control-Allow-Origin", "*")
        self.set_header("Access-Control-Allow-Headers", "x-requested-with,authorization")
        self.set_header('Access-Control-Allow-Methods', 'POST,GET,PUT,DELETE,OPTIONS')

    def get(self):
        type = self.get_argument('type')
        if type == 'school':
            school = self.get_argument('info')
            res = self.handler.select("select * from school where school_name = %s", (school))
            print(res)
            pack = {'success': len(res) > 0, 'data': res}
            self.write(json.dumps(pack))
        elif type == 'sid':
            sid = self.get_argument('info')
            res = self.handler.select("select * from login where sid = %s", (sid))
            print(res)
            pack = {'success': len(res) > 0, 'data': res}
            self.write(json.dumps(pack))
        else:
            pack = {'success': False, 'data': []}
            self.write(json.dumps(pack))

    def post(self):
        sid = self.get_argument('usr')
        pwd = self.get_argument('pwd')
        name = self.get_argument('name')
        schoolId = self.get_argument('school')
        print("register, ", sid, pwd, name, schoolId)
        if self.handler.insert(
                "insert into person (sid, team_id, school_id, name, rating) values (%s, null, %s, %s, null)",
                (sid, schoolId, name)) and \
                self.handler.insert("insert into login (sid, pwd) values(%s,%s)",
                                    (sid, pwd)):
            self.handler.commit()
            pack = {'success': True, 'data': []}
            self.write(json.dumps(pack))
        else:
            self.handler.rollback()
            pack = {'success': False, 'data': []}
            self.write(json.dumps(pack))


class loginHandler(tornado.web.RequestHandler):
    def initialize(self):
        self.handler = sqlHandler(dbUsername, dbPassword, dbDatabase, dbHost, dbPort)

    def set_default_headers(self):
        self.set_header("Access-Control-Allow-Origin", "*")
        self.set_header("Access-Control-Allow-Headers", "x-requested-with,authorization")
        self.set_header('Access-Control-Allow-Methods', 'POST,GET,PUT,DELETE,OPTIONS')

    def post(self):
        usr = self.get_argument('usr')
        pwd = self.get_argument('pwd')
        print("login, ", usr, pwd)
        res = self.handler.select("select pwd from login where sid = %s", (usr))

        if res[0]['pwd'] == pwd:
            pack = {'success': True, 'data': []}
            self.write(json.dumps(pack))
        else:
            pack = {'success': False, 'data': []}
            self.write(json.dumps(pack))
    def get(self):
        self.write("hello")


if __name__ == '__main__':
    app = tornado.web.Application([(r"/login", loginHandler), (r"/register", registerHandler)])
    port = tornado.options.options.port
    app.listen(port)
    print("Running on port", port)
    tornado.ioloop.IOLoop.current().start()
