from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, SubmitField, TextAreaField, RadioField, DecimalField, SelectField
from wtforms.validators import DataRequired


# 管理员登录表单
class LoginForm(FlaskForm):
    manager = StringField(
        label="AdminName",
        validators=[
            DataRequired("Administrator name cannot be empty!")
        ],
        description="AdminName",
        render_kw={
            "class": "manager",
            "placeholder": "Please enter the administrator name!",
        }
    )
    password = PasswordField(
        label="Password",
        validators=[
            DataRequired("Password cannot be empty!")
        ],
        description="Password",
        render_kw={
            "class": "password",
            "placeholder": "Please enter the password!",
        }
    )
    submit = SubmitField(
        'Login',
        render_kw={
            "class": "login_ok",
        }
    )


# 商品表单
class GoodsForm(FlaskForm):
    name = StringField(
        label="Title",
        validators=[
            DataRequired("Title cannot be empty!"),
        ],
        description="Title",
        render_kw={
            "class": "Sytle_text",
            "placeholder": "Please enter the title!",
            "size": "50"
        }
    )
    supercat_id = SelectField(
        label="SuperCategory",
        validators=[
            DataRequired("Please select a super category!")
        ],
        coerce=int,
        description="SuperCategory",
        render_kw={
            "class": "form-control",
        }
    )

    subcat_id = SelectField(
        label="SubCategory",
        validators=[
            DataRequired("Please select a sub category!")
        ],
        coerce=int,
        description="SubCategory",
        render_kw={
            "class": "form-control",
        }
    )
    picture = StringField(
        label="Picture",
        validators=[
            DataRequired("The picture name cannot be empty!")
        ],
        description="Picture",
        render_kw={
            "class": "Style_upload",
            "placeholder": "Please enter the picture name!"
        }
    )
    original_price = DecimalField(
        label="OriginalPrice",
        validators=[
            DataRequired("Please enter the correct price type!")
        ],
        description="OriginalPrice",
        render_kw={
            "class": "Sytle_text",
            "placeholder": "Please enter a price!"
        }
    )
    current_price = DecimalField(
        label="CurrentPrice",
        validators=[
            DataRequired("The current price cannot be empty!")
        ],
        description="CurrentPrice",
        render_kw={
            "class": "Sytle_text",
            "placeholder": "Please enter a price!"
        }
    )
    is_new = RadioField(
        label='IsNew',
        description="IsNew",
        coerce=int,
        choices=[(0, 'False'), (1, 'True')], default=0,
        render_kw={
            "class": "is_radio"
        }
    )
    is_sale = RadioField(
        label='IsSale',
        description="IsSale",
        coerce=int,
        choices=[(0, 'False'), (1, 'True')], default=0,
        render_kw={
            "class": "is_radio"
        }
    )
    introduction = TextAreaField(
        label="Description",
        validators=[
            DataRequired("The description cannot be empty!")
        ],
        description="Description",
        render_kw={
            "class": "textarea",
            "rows": 5
        }
    )
    submit = SubmitField(
        'Save',
        render_kw={
            "class": "btn_bg_short",
        }
    )
