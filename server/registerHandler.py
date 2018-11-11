import json
import tornado.web

from config import *
from sqlHandler import *
from logger import GetLogger

logger = GetLogger(__name__)

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
            res = self.handler.select("select school_name from school where school_name = %s", school)
            info = school + " {}".format("exists" if len(res) > 0 else "no")
            logger.info(info)
            pack = {'success': len(res) > 0, 'data': res}
            self.write(json.dumps(pack))
        elif type == 'sid':
            sid = self.get_argument('info')
            res = self.handler.select("select sid from login where sid = %s", sid)
            info = sid + " {}".format("exists" if len(res) > 0 else "no")
            logger.info(info)
            pack = {'success': len(res) > 0, 'data': res}
            self.write(json.dumps(pack))
        else:
            logger.info("unknown query type")
            pack = {'success': False, 'data': []}
            self.write(json.dumps(pack))

    def post(self):
        sid = self.get_argument('usr')
        pwd = self.get_argument('pwd')
        name = self.get_argument('name')
        school_id = self.get_argument('school')

        ok1 = self.handler.insert(
            "insert into person (sid, team_id, school_id, name, rating) values (%s, null, %s, %s, null)",
            (sid, school_id, name))
        ok2 = self.handler.insert("insert into login (sid, pwd) values(%s,%s)", (sid, pwd))

        info = "[{}, {}, {}]".format(sid, name, school_id)

        if ok1 and ok2:
            info += " registered"
            logger.info(info)
            pack = {'success': True, 'data': []}
            self.handler.commit()
            self.write(json.dumps(pack))
        else:
            info += " register fail"
            logger.info(info)
            pack = {'success': False, 'data': []}
            self.handler.rollback()
            self.write(json.dumps(pack))
