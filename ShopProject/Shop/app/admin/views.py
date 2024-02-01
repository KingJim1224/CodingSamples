from app import db
from . import admin
from flask import render_template, redirect, url_for, flash, session, request, jsonify
from app.admin.forms import LoginForm, GoodsForm
from app.models import Admin, Goods, SuperCat, SubCat, User, Orders, OrdersDetail, Customers
from sqlalchemy import or_
from sqlalchemy import func
from functools import wraps
from decimal import *


# 登录装饰器,检测管理员是否登录
def admin_login(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        # seesion中无值，跳转到登录界面
        if "admin" not in session:
            return redirect(url_for("admin.login", next=request.url))
        return f(*args, **kwargs)

    return decorated_function


# 管理员登录
@admin.route("/login/", methods=["GET", "POST"])
def login():
    # 判断是否已经登录
    if "admin" in session:
        return redirect(url_for("admin.index"))
    form = LoginForm()  # 实例化登录表单
    if form.validate_on_submit():  # 验证提交表单
        data = form.data  # 接收数据
        admin = Admin.query.filter_by(manager=data["manager"]).first()  # 查找Admin表数据
        # 密码错误时，check_password,则此时not check_password(data["pwd"])为真。
        if not admin.check_password(data["password"]):
            flash("Password Wrong!", "err")  # 闪存错误信息
            return redirect(url_for("admin.login"))  # 跳转到后台登录页
        # 如果是正确的，就要定义session的会话进行保存。
        session["admin"] = data["manager"]  # 存入session
        session["admin_id"] = admin.id  # 存入session
        return redirect(url_for("admin.index"))  # 返回后台主页
    return render_template("admin/login.html", form=form)


# 配置路由
@admin.route("/")
# 登录验证
@admin_login
def index():
    page = request.args.get('page', 1, type=int)  # 获取page参数值
    # 获取页面商品数据，按照添加时间降序显示
    page_data = Goods.query.order_by(Goods.addtime.desc()).paginate(page=page, per_page=10)
    return render_template("admin/index.html", page_data=page_data)


# 添加商品
@admin.route("/goods/add/", methods=["GET", "POST"])
@admin_login
def goods_add():
    form = GoodsForm()  # 实例化form表单
    # 获取分类选择时的文本
    supercat_list = [(v.id, v.cat_name) for v in SuperCat.query.all()]  # 为super_cat_id添加属性
    form.supercat_id.choices = supercat_list  # 为super_cat_id添加属性
    form.subcat_id.choices = [(v.id, v.cat_name) for v in
                              SubCat.query.filter_by(super_cat_id=supercat_list[0][0]).all()]  # 为super_cat_id添加属性
    form.current_price.data = form.data['original_price']  # 为current_pirce 赋值
    if form.validate_on_submit():  # 添加商品情况
        data = form.data
        goods = Goods(
            name=data["name"],
            supercat_id=int(data['supercat_id']),
            subcat_id=int(data['subcat_id']),
            picture=data["picture"],
            original_price=Decimal(data["original_price"]).quantize(Decimal('0.00')),  # 转化为包含2位小数的形式
            current_price=Decimal(data["original_price"]).quantize(Decimal('0.00')),  # 转化为包含2位小数的形式
            is_new=int(data["is_new"]),
            is_sale=int(data["is_sale"]),
            introduction=data["introduction"],
        )
        db.session.add(goods)  # 添加数据
        db.session.commit()  # 提交数据
        return redirect(url_for('admin.index'))  # 页面跳转
    return render_template("admin/goods_add.html", form=form)  # 渲染模板


# 商品详情
@admin.route("/goods/detail/", methods=["GET", "POST"])
@admin_login
def goods_detail():
    goods_id = request.args.get('goods_id')
    goods = Goods.query.filter_by(id=goods_id).first_or_404()
    return render_template('admin/goods_detail.html', goods=goods)


# 编辑商品
@admin.route("/goods/edit/<int:id>", methods=["GET", "POST"])
@admin_login
def goods_edit(id=None):
    goods = Goods.query.get_or_404(id)
    form = GoodsForm()  # 实例化form表单
    form.supercat_id.choices = [(v.id, v.cat_name) for v in SuperCat.query.all()]  # 为super_cat_id添加属性
    form.subcat_id.choices = [(v.id, v.cat_name) for v in
                              SubCat.query.filter_by(super_cat_id=goods.supercat_id).all()]  # 为super_cat_id添加属性
    # 显示修改前的内容
    if request.method == "GET":
        form.name.data = goods.name
        form.picture.data = goods.picture
        form.current_price.data = goods.current_price
        form.original_price.data = goods.original_price
        form.supercat_id.data = goods.supercat_id
        form.subcat_id.data = goods.subcat_id
        form.is_new.data = goods.is_new
        form.is_sale.data = goods.is_sale
        form.introduction.data = goods.introduction
    # 提交修改后的内容
    elif form.validate_on_submit():
        goods.name = form.data["name"]
        goods.supercat_id = int(form.data['supercat_id'])
        goods.subcat_id = int(form.data['subcat_id'])
        goods.picture = form.data["picture"]
        goods.original_price = Decimal(form.data["original_price"]).quantize(Decimal('0.00'))
        goods.current_price = Decimal(form.data["current_price"]).quantize(Decimal('0.00'))
        goods.is_new = int(form.data["is_new"])
        goods.is_sale = int(form.data["is_sale"])
        goods.introduction = form.data["introduction"]
        db.session.add(goods)  # 添加数据
        db.session.commit()  # 提交数据
        return redirect(url_for('admin.index'))  # 页面跳转

    return render_template("admin/goods_edit.html", form=form)  # 渲染模板


# 查找子分类数据
@admin.route("/goods/select_sub_cat/", methods=["GET"])
@admin_login
def select_sub_cat():
    super_id = request.args.get("super_id", "")  # 接收传递的参数super_id
    subcat = SubCat.query.filter_by(super_cat_id=super_id).all()
    result = {}
    if subcat:
        data = []
        for item in subcat:
            data.append({'id': item.id, 'cat_name': item.cat_name})
        result['status'] = 1
        result['message'] = 'ok'
        result['data'] = data
    else:
        result['status'] = 0
        result['message'] = 'error'
    return jsonify(result)  # 返回json数据


# 点击删除商品
@admin.route("/goods/del_confirm/")
@admin_login
def goods_del_confirm():
    goods_id = request.args.get('goods_id')
    goods = Goods.query.filter_by(id=goods_id).first_or_404()
    return render_template('admin/goods_del_confirm.html', goods=goods)


# 提交删除商品
@admin.route("/goods/del/<int:id>/", methods=["GET"])
@admin_login
def goods_del(id=None):
    goods = Goods.query.get_or_404(id)  # 根据商品ID查找数据
    db.session.delete(goods)  # 删除数据
    db.session.commit()  # 提交数据
    return redirect(url_for('admin.index', page=1))  # 渲染模板


# 退出登录
@admin.route('/logout/')
@admin_login
def logout():
    # 销毁session
    session.pop("admin", None)
    session.pop("admin_id", None)
    return redirect(url_for("admin.login"))


# 查看用户列表
@admin.route("/user/list/", methods=["GET"])
@admin_login
def user_list():
    page = request.args.get('page', 1, type=int)  # 获取page参数值
    keyword = request.args.get('keyword', '', type=str)
    if keyword:
        # 根据姓名或者邮箱查询
        filters = or_(User.username == keyword, User.email == keyword)
        page_data = User.query.filter(filters).order_by(
            User.addtime.desc()
        ).paginate(page=page, per_page=5)
    else:
        page_data = User.query.order_by(
            User.addtime.desc()
        ).paginate(page=page, per_page=5)

    return render_template("admin/user_list.html", page_data=page_data)


# 查看会员信息
@admin.route("/user/view/<int:id>/", methods=["GET"])
@admin_login
def user_view(id=None):
    from_page = request.args.get('fp')
    if not from_page:
        from_page = 1
    user = User.query.get_or_404(int(id))
    return render_template("admin/user_view.html", user=user, from_page=from_page)


# 添加大分类
@admin.route('/supercat/add/', methods=["GET", "POST"])
@admin_login
def supercat_add():
    if request.method == 'POST':
        cat_name = request.form['cat_name']
        supercat = SuperCat.query.filter_by(cat_name=cat_name).count()
        if supercat:
            flash("Super category exists", "err")
            return redirect(url_for("admin.supercat_add"))
        data = SuperCat(
            cat_name=cat_name,
        )
        db.session.add(data)
        db.session.commit()
        return redirect(url_for("admin.supercat_list"))
    return render_template("admin/supercat_add.html")


# 大分类列表
@admin.route("/supercat/list/", methods=["GET"])
@admin_login
def supercat_list():
    data = SuperCat.query.order_by(SuperCat.addtime.desc()).all()
    return render_template("admin/supercat.html", data=data)  # 渲染模板


# 删除大分类
@admin.route("/supercat/del/", methods=["POST"])
@admin_login
def supercat_del():
    if request.method == 'POST':
        cat_ids = request.form.getlist("delid")  # cat_ids 是一个列表
        # 判断是否有子类
        for id in cat_ids:
            count = SubCat.query.filter_by(super_cat_id=id).count()
            if count:
                return "There are subcats under the supercats, please delete the subcat first"
        # 使用in_ 方式批量删除，需要设置synchronize_session为False,而 in 操作估计还不支持
        # 解决办法就是删除时不进行同步，然后再让 session 里的所有实体都过期
        db.session.query(SuperCat).filter(SuperCat.id.in_(cat_ids)).delete(synchronize_session=False)
        db.session.commit()
        return redirect(url_for("admin.supercat_list"))


# 小分类列表
@admin.route("/subcat/list/", methods=["GET"])
@admin_login
def subcat_list():
    data = SubCat.query.order_by(
        SubCat.addtime.desc()
    ).all()
    return render_template("admin/subcat.html", data=data)  # 渲染模板


# 添加小分类
@admin.route('/subcat/add/', methods=["GET", "POST"])
@admin_login
def subcat_add():
    if request.method == 'POST':
        cat_name = request.form['cat_name']
        super_cat_id = request.form['super_cat_id']
        # 检测名称是否存在
        subcat = SubCat.query.filter_by(cat_name=cat_name).count()
        if subcat:
            return "<script>alert('Subcat exists');history.go(-1);</script>"
        # 组织数据
        data = SubCat(
            super_cat_id=super_cat_id,
            cat_name=cat_name,
        )
        db.session.add(data)
        db.session.commit()
        return redirect(url_for("admin.subcat_list"))

    supercat = SuperCat.query.all()  # 获取大分类信息
    return render_template("admin/subcat_add.html", supercat=supercat)


# 删除小分类
@admin.route("/subcat/del/", methods=["POST"])
@admin_login
def subcat_del():
    if request.method == 'POST':
        cat_ids = request.form.getlist("delid")  # cat_ids 是一个列表
        # 判断子类下是否有商品
        for id in cat_ids:
            count = Goods.query.filter_by(subcat_id=id).count()
            if count:
                return "<script>alert('There are goods under this subcat, please delete the goods under the subcat first');history.go(-1);</script>"
        db.session.query(SubCat).filter(SubCat.id.in_(cat_ids)).delete(synchronize_session=False)
        db.session.commit()
        return redirect(url_for("admin.subcat_list"))


# 订单列表页面
@admin.route("/orders/list/", methods=["GET"])
@admin_login
def orders_list():
    keywords = request.args.get('keywords', '', type=str)
    page = request.args.get('page', 1, type=int)  # 获取page参数值
    if keywords:
        page_data = Orders.query.filter_by(id=keywords).order_by(
            Orders.addtime.desc()
        ).paginate(page=page, per_page=10)
    else:
        page_data = Orders.query.order_by(
            Orders.addtime.desc()
        ).paginate(page=page, per_page=10)
    return render_template("admin/orders_list.html", page_data=page_data)


# 搜索sql页面
@admin.route("/search/", methods=["GET"])
@admin_login
def search():
    keywords = request.args.get('keywords', '', type=str)
    product_info = None  # Define product_info with a default value
    total_sales_count = 0
    total_sales = 0
    total_profit = 0
    top_customer_name = None
    top_customer_purchases = 0

    # 查询特定产品的总销售额和利润
    if keywords:
        product_info = Goods.query.filter(Goods.name.ilike(f"%{keywords}%")).first()
        if product_info:
            total_sales_count = OrdersDetail.query.filter_by(goods_id=product_info.id).join(Orders).count()
            current_price_float = float(product_info.current_price)
            total_sales = total_sales_count * current_price_float
            total_profit = total_sales_count * (current_price_float * 0.4)

    # 哪些企业购买指定产品最多？
    top_customer_purchase_query = db.session.query(OrdersDetail.goods_id,
                                                    func.sum(OrdersDetail.number).label('total_purchases'),
                                                    Orders.recevie_name). \
        join(Orders).filter(Goods.id == OrdersDetail.goods_id,
                            Goods.name.ilike(f"%{keywords}%")).group_by(Orders.recevie_name,
                                                                        OrdersDetail.goods_id).all()

    if top_customer_purchase_query:
        top_customer_purchase = max(top_customer_purchase_query, key=lambda x: x.total_purchases)
        top_customer_name = top_customer_purchase.recevie_name
        top_customer_purchases = top_customer_purchase.total_purchases

    return render_template("admin/search.html", keywords=keywords, product_info=product_info,
                           total_sales_count=total_sales_count, total_sales=total_sales, total_profit=total_profit,
                           top_customer_name=top_customer_name, top_customer_purchases=top_customer_purchases)

# Add any other routes or functions as needed


# New route for generating pie chart
@admin.route("/piechart/", methods=["GET"])
@admin_login
def piechart():
    keywords = request.args.get('keywords', '', type=str)

    if keywords:
        # Retrieve data for the pie chart
        sales_by_region = db.session.query(OrdersDetail.goods_id,
                                           func.sum(OrdersDetail.number).label('total_sales'),
                                           Orders.recevie_address). \
            join(Orders).filter(Goods.id == OrdersDetail.goods_id,
                                Goods.name == keywords).group_by(Orders.recevie_address,
                                                                 OrdersDetail.goods_id).all()

        labels = [region.recevie_address for region in sales_by_region]
        values = [float(region.total_sales) for region in sales_by_region]

        return render_template("admin/piechart.html", keywords=keywords, labels=labels, values=values)

    # Render the template without data if no keyword is provided
    return render_template("admin/piechart.html")

# 订单详情
@admin.route("/orders/detail/", methods=["GET"])
@admin_login
def orders_detail():
    order_id = request.args.get('order_id')
    orders = OrdersDetail.query.join(Orders).filter(OrdersDetail.order_id == order_id).all()
    return render_template('admin/orders_detail.html', data=orders)


# 销量排行前10位
@admin.route('/topgoods/', methods=['GET'])
@admin_login
def topgoods():
    # Group by goods_id, sum the quantity across orders, and limit to top 10
    top_goods = db.session.query(OrdersDetail.goods_id, func.sum(OrdersDetail.number).label('number_sum')) \
        .group_by(OrdersDetail.goods_id) \
        .order_by(func.sum(OrdersDetail.number).desc()) \
        .limit(10) \
        .all()

    # Fetch the actual Goods objects using the IDs obtained above
    goods_data = []
    for goods_id, quantity_sum in top_goods:
        goods = Goods.query.get(goods_id)
        goods_data.append({'goods': goods, 'number': quantity_sum})

    return render_template("admin/topgoods.html", data=goods_data)
