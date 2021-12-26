# coding:utf-8
import os
from pre_data import analyze_pre_data as apd
from tools.read_yml import PyrunConfig
from pre_data import ExcelUtil

'''
20211223
拼接业务各字段，组成一个可以直接执行的sql语句

'''
sheet_names = ['沪A', '沪B', '沪港', '深A', '深B', '深港', '股转A', '股转B']
file = r'F:\11-开发项目\pyrun_rebuild\pyrun_rebuild\all_excel_cases\JZJY-全量基线模板-案例.xlsx'
sql_path = r'F:\11-开发项目\pyrun_rebuild\pyrun_rebuild\SQL\SQL_JZJY'


def list_dir(sql_path):
    list_name = []
    for i in os.listdir(sql_path):
        if os.path.splitext(i)[1] == '.sql':
            list_name.append(i)
    return list_name


# 读取指定的sql文件
def sql_str(sql_path1, sql_name):
    with open(sql_path1 + '\\' + sql_name, 'r', encoding='utf8') as f:
        sql_txt = f.readlines()
        sql_txt = ''.join(sql_txt)
    return sql_txt


def format_sql(data, line, class_object, sql_path):
    '''
    解析处理sql文件，将参数拼接后形成可以直接执行的sql语句
    :param data: dict
    :param line: int
    :param class_object:object
    :param sql_path:string
    :return: String
    '''
    business_dict = business_cfg.read_business_config()
    line_data = data[line]
    market = str(line_data.get('市场')).strip()
    sec_type = str(line_data.get('证券类别')).strip()
    sec_variety = str(line_data.get('证券品种')).strip()
    business_type = line_data.get('业务').strip()
    allow_branch_code = class_object.get_allow_branch_code(line)
    disabled_branch_code = class_object.get_disabled_branch_code(line)
    disabled_cust_no = class_object.get_disabled_cust_no(line)
    allow_seat_no = class_object.get_allow_seat_no(line)
    disabled_seat_no = class_object.get_disabled_seat_no(line)

    if sec_type == '10':
        attribute = '1'
    else:
        attribute = '0'

    if (market == '2' and sec_type == '45' and sec_variety == '56'):
        sec_level = 'E'
    else:
        sec_level = '0'

    buy_name = business_dict[business_type]['买客户']
    sell_name = business_dict[business_type]['卖客户']
    sec_name = business_dict[business_type]['证券代码']

    # print(buy_name,sell_name,sec_name)
    sql = get_buy(data,buy_name,class_object,line,attribute,sec_level)

    return sql


def get_buy(data,name,class_object,line,attribute,sec_level):
    line_data = data[line]
    market = str(line_data.get('市场')).strip()
    allow_branch_code = class_object.get_allow_branch_code(line)
    disabled_branch_code = class_object.get_disabled_branch_code(line)
    disabled_cust_no = class_object.get_disabled_cust_no(line)
    allow_seat_no = class_object.get_allow_seat_no(line)
    disabled_seat_no = class_object.get_disabled_seat_no(line)

    buy_sql = sql_str(sql_path, name).format(
        attribute=attribute,
        market=market,
        disabled_cust_no=disabled_cust_no,
        allow_seat_no=allow_seat_no,
        disabled_seat_no=disabled_seat_no,
        allow_branch_code=allow_branch_code,
        disabled_branch_code=disabled_branch_code)

    return buy_sql

# def get_sell(name):
#     sell_sql = sql_str(sql_path, sell_name).format(
#         attribute=attribute,
#         market=market,
#         sec_type = sec_type,
#         disabled_cust_no=disabled_cust_no,
#         sec_variety=sec_variety,
#         sec_level = sec_level,
#         allow_branch_code=allow_branch_code,
#         disabled_branch_code=disabled_branch_code,
#         allow_seat_no=allow_seat_no,
#         disabled_seat_no=disabled_seat_no,
#        )

def get_lg():
    pass



app_cfg = PyrunConfig('app_config.yml')
business_cfg = PyrunConfig('business_config.yml')
# data_source, detail = app_cfg.read_app_config()
# business = business_cfg.read_business_config()


filter_data = ExcelUtil.filter_pre_data(ExcelUtil.load_pre_data_excel())  #只包含自动准备数据为是的行数据
disable_allow_arg = apd.analyze(filter_data)
sql_str = format_sql(filter_data, 2, disable_allow_arg, sql_path)
print(sql_str)

