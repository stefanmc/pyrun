# coding:utf-8
# from pre_data.ExcelUtil import load_pre_data_excel


class analyze:
    def __init__(self, data):
        self.data = data

    def get_allow_branch_code(self, lines):
        line_data = self.data[lines]
        line_branch_code = line_data.get('指定营业部').split('@')
        if len(line_branch_code) == 1:  # 说明不需要指定营业部号
            allow_branch_code = r''
        elif len(line_branch_code) == 2:  # 说明只有一个指定的营业部号
            allow_branch_code = f"AND a.BRANCH_CODE = '{line_branch_code[1]}'"
        else:
            line_branch_code = tuple(line_branch_code[1:])
            allow_branch_code = f"AND a.BRANCH_CODE IN {line_branch_code}"

        return allow_branch_code

    def get_disabled_branch_code(self, lines):
        line_data = self.data[lines]
        line_branch_code = line_data.get('禁用营业部').split('@')
        if len(line_branch_code) == 1:  # 说明不需要禁用营业部号
            disabled_branch_code = r''
        elif len(line_branch_code) == 2:  # 说明只有一个禁用的营业部号
            disabled_branch_code = f"AND a.BRANCH_CODE != '{line_branch_code[1]}'"
        else:
            line_branch_code = tuple(line_branch_code[1:])
            disabled_branch_code = f"AND a.BRANCH_CODE NOT IN {line_branch_code}"

        return disabled_branch_code


    def get_disabled_cust_no(self, lines):
        line_data = self.data[lines]
        line_cust_no = line_data.get('禁用客户号').split('@')
        allow_cust_no = tuple(line_cust_no[1:])

        return allow_cust_no

    def get_allow_seat_no(self, lines):
        line_data = self.data[lines]
        line_seat_no = line_data.get('指定席位号').split('@')
        if len(line_seat_no) == 1:  # 说明不需要指定席位号
            allow_seat_no = r''
        elif len(line_seat_no) == 2:  # 说明只有一个指定的席位号
            allow_seat_no = f"AND D1.SEAT_NO IN = '{line_seat_no[1]}'"
        else:
            line_seat_no = tuple(line_seat_no[1:])
            allow_seat_no = f"AND D1.SEAT_NO IN {line_seat_no}"

        return allow_seat_no

    def get_disabled_seat_no(self, lines):
        line_data = self.data[lines]
        line_seat_no = line_data.get('禁用席位号').split('@')
        if len(line_seat_no) == 1:  # 说明不需要禁用席位号
            disabled_seat_no = r''
        elif len(line_seat_no) == 2:  # 说明只有一个指定的禁止席位号
            disabled_seat_no = f"AND D1.SEAT_NO != '{line_seat_no[1]}'"
        else:
            line_seat_no = tuple(line_seat_no[1:])
            disabled_seat_no = f"AND D1.SEAT_NO NOT IN {line_seat_no}"

        return disabled_seat_no

#
# if __name__ == '__main__':
#     data = load_pre_data_excel()
#     a = analyze(data)
#     print(a.get_allow_branch_code(2))
#     print(a.get_disabled_branch_code(2))
#     print(a.get_disabled_cust_no(2))
#     print(a.get_allow_seat_no(2))
#     print(a.get_disabled_seat_no(2))
