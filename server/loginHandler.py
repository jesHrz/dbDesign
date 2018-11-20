import json

import tornado.web

from config import *
from logger import GetLogger
from sqlHandler import *

logger = GetLogger(__name__)


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
        res = self.handler.select("select pwd from login where sid = %s", (usr))

        if len(res) > 0:
            pack = {'success': res[0]['pwd'] == pwd, 'data': []}
            info = usr + ", login {}".format("successfully" if res[0]['pwd'] == pwd else "failed")
            logger.info(info)
            self.write(json.dumps(pack))

    def get(self):
        logger.info("some one say \"Hello\"")
        self.write("hello")
