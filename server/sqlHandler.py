import pymysql


class sqlHandler():
    def __init__(self, _user, _password, _database, _host, _port=3306):
        self.db = pymysql.connect(
            host=_host,
            port=_port,
            user=_user,
            password=_password,
            database=_database
        )

    def __del__(self):
        self.db.close()

    def select(self, command, args=None):
        try:
            cursor = self.db.cursor(cursor=pymysql.cursors.DictCursor)
            cursor.execute(command, args)
            result = cursor.fetchall()
            cursor.close()
            return result
        except:
            cursor.close()
            return []

    def insert(self, command, args=None):
        try:
            cursor = self.db.cursor(cursor=pymysql.cursors.DictCursor)
            cursor.execute(command, args)
            return True
        except:
            self.db.rollback()
            return False

    def update(self, command, args=None):
        try:
            cursor = self.db.cursor(cursor=pymysql.cursors.DictCursor)
            cursor.execute(command, args)
            return True
        except:
            self.db.rollback()
            return False

    def delete(self, command, args=None):
        try:
            cursor = self.db.cursor(cursor=pymysql.cursors.DictCursor)
            cursor.execute(command, args)
            return True
        except:
            self.db.rollback()
            return False

    def commit(self):
        self.db.commit()

    def rollback(self):
        self.db.rollback()
