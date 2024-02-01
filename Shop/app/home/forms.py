from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, SubmitField
from wtforms.validators import DataRequired, Email, Regexp, EqualTo, ValidationError, Length

from app.models import User


# 注册表单
class RegisterForm(FlaskForm):
    username = StringField(
        label="Username ：",
        validators=[
            DataRequired("The username cannot be empty!"),
            Length(min=3, max=50, message="The username must be between 3 and 10 digits in length.")
        ],
        description="Username",
        render_kw={
            "type": "text",
            "placeholder": "Please enter username!",
            "class": "validate-username",
            "size": 38,
        }
    )
    phone = StringField(
        label="Phone ：",
        validators=[
            DataRequired("The phone number cannot be empty!"),
            Regexp("^(\+1)?\s?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$", message="Incorrectly formatted phone number.")
        ],
        description="Phone",
        render_kw={
            "type": "text",
            "placeholder": "Please enter a phone number!",
            "size": 38,
        }
    )
    email = StringField(
        label="Email ：",
        validators=[
            DataRequired("The mailbox cannot be empty!"),
            Email("The mailbox is not formatted correctly!")
        ],
        description="Email",
        render_kw={
            "type": "email",
            "placeholder": "Please enter your e-mail address!",
            "size": 38,
        }
    )
    password = PasswordField(
        label="Password ：",
        validators=[
            DataRequired("The password cannot be empty!")
        ],
        description="Password",
        render_kw={
            "placeholder": "Please enter your password!",
            "size": 38,
        }
    )
    repassword = PasswordField(
        label="Repassword ：",
        validators=[
            DataRequired("Please enter your password again!"),
            EqualTo('password', message="The two passwords do not match!")
        ],
        description="Repassword",
        render_kw={
            "placeholder": "Please enter your password again!",
            "size": 38,
        }
    )
    submit = SubmitField(
        'Register',
        render_kw={
            "class": "btn btn-primary login",
        }
    )

    # 邮箱验证是否已存在
    def validate_email(self, field):
        email = field.data
        user = User.query.filter_by(email=email).count()
        if user == 1:
            raise ValidationError("The email already exists!")

    # 手机号验证是否已存在
    def validate_phone(self, field):
        phone = field.data
        user = User.query.filter_by(phone=phone).count()
        if user == 1:
            raise ValidationError("The phone number already exists!")


# 登录表单
class LoginForm(FlaskForm):
    username = StringField(
        validators=[
            DataRequired("The username cannot be empty!"),
            Length(min=3, max=50, message="The username must be between 3 and 10 digits in length.")
        ],
        description="Username",
        render_kw={
            "type": "text",
            "placeholder": "Please enter username! ",
            "class": "validate-username",
            "size": 38,
            "maxlength": 99
        }
    )
    password = PasswordField(
        validators=[
            DataRequired("The password cannot be empty!"),
            Length(min=3, message="Password length not less than 6 digits.")
        ],
        description="Password",
        render_kw={
            "type": "password",
            "placeholder": "Please enter your password!",
            "class": "validate-password",
            "size": 38,
            "maxlength": 99
        }
    )
    verify_code = StringField(
        'VerifyCode',
        validators=[DataRequired()],
        render_kw={
            "class": "validate-code",
            "size": 18,
            "maxlength": 4,
        }
    )

    submit = SubmitField(
        'Login',
        render_kw={
            "class": "btn btn-primary login",
        }
    )


# 修改密码表单
class PasswordForm(FlaskForm):
    old_password = PasswordField(
        label="OriginalPwd ：",
        validators=[
            DataRequired("The original password cannot be empty!")
        ],
        description="OriginalPwd",
        render_kw={
            "placeholder": "Please enter the original password!",
            "size": 38,
        }
    )
    password = PasswordField(
        label="NewPwd ：",
        validators=[
            DataRequired("The password cannot be empty!")
        ],
        description="Password",
        render_kw={
            "placeholder": "Please enter your password!",
            "size": 38,
        }
    )
    repassword = PasswordField(
        label="Repassword ：",
        validators=[
            DataRequired("Please enter your password again!"),
            EqualTo('password', message="The two passwords do not match!")
        ],
        description="Repassword",
        render_kw={
            "placeholder": "Please enter your password again!",
            "size": 38,
        }
    )
    submit = SubmitField(
        'Confirm',
        render_kw={
            "class": "btn btn-primary login",
        }
    )

    # 旧密码验证
    def validate_old_password(self, field):
        from flask import session
        old_password = field.data
        user_id = session["user_id"]
        user = User.query.get(int(user_id))
        if not user.check_password(old_password):
            raise ValidationError("The original password is incorrect!")
