#coding:utf-8
import pandas as pd
from pandas import DataFrame
import os


df = pd.read_excel(r'F:\11-开发项目\pyrun_rebuild\pyrun_rebuild\all_excel_cases\JZJY-全量基线模板-案例.xlsx',sheet_name='数据准备')
cols = df.columns
headers = [i for i in cols]
# print(headers)
# print(df.index.values)
line1 = df.loc[df.index.values]
lines = df.index
print(lines)

# print(df.loc[0].values)