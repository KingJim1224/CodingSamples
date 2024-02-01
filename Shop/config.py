
class Config:
    SECRET_KEY = 'bhml2023'
    SQLALCHEMY_TRACK_MODIFICATIONS = True

    @staticmethod
    def init_app(app):
        pass


class DevelopmentConfig(Config):
    SQLALCHEMY_DATABASE_URI = 'mysql+pymysql://root:zj241817@127.0.0.1:3306/db_shop'
    DEBUG = True


config = {
    'default': DevelopmentConfig
}
