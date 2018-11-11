import tornado.options
import tornado.ioloop
import tornado.web

import registerHandler
import loginHandler

tornado.options.define("port", default=8080, type=int, help="run server on the given port.") # 定义服务器监听端口选项

if __name__ == '__main__':
    port = tornado.options.options.port
    app = tornado.web.Application([
            (r"/login", loginHandler.loginHandler),
            (r"/register", registerHandler.registerHandler)
    ])
    print("Running on port", port)
    app.listen(port)
    tornado.ioloop.IOLoop.current().start()
