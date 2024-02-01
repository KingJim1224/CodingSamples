from flask import render_template
from flask_migrate import Migrate, MigrateCommand
from flask_script import Manager, Shell

'''
数据库迁移
迁移命令
1.python manage.py db init
2.python manage.py db migrate
3.python manage.py db upgrade
'''

from app import create_app
from app.models import *

'''
Flask-Script是一个让你的命令行支持自定义命令的工具，
它为Flask程序添加一个命令行解释器。可以让我们的程序从命令行直接执行相应的程序。
'''

# 创建应用
app = create_app('default')
manager = Manager(app)
migrate = Migrate(app, db)



def make_shell_context():
    return dict(app=app, db=db)



manager.add_command("shell", Shell(make_context=make_shell_context))
manager.add_command('db', MigrateCommand)



@app.errorhandler(404)
def page_not_found(error):
    return render_template("home/404.html"), 404


if __name__ == '__main__':

    manager.run()
