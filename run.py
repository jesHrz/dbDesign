import tornado.options
import tornado.ioloop
import tornado.web

import os

from server import RegisterHandler
from server import LoginHandler
from config import current_path

tornado.options.define("port", default=8080, type=int, help="run server on the given port.")  # 定义服务器监听端口选项

if __name__ == '__main__':
    port = tornado.options.options.port
    app = tornado.web.Application(
        [
            (r"/", LoginHandler.LoginHandler),
            (r"/login", LoginHandler.LoginHandler),
            (r"/register", RegisterHandler.RegisterHandler),
            (r"/register-check", RegisterHandler.RegisterChecker),
        ],
        static_path=os.path.join(current_path, 'static'),
    )
    print("Running on port", port)
    app.listen(port)
    tornado.ioloop.IOLoop.current().start()
