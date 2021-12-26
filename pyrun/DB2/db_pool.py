# -*- coding: UTF-8 -*-
import ibm_db, time


def work(pool, command, mode):
    # while True:
    conn = pool.getconnect()
    if conn:
        try:
            pass
            stmt = ibm_db.prepare(conn, command)
            ibm_db.execute(stmt)
            if mode == 'S':
                result = ibm_db.fetch_both(stmt)
                while (result):
                    return result
            elif mode == 'SS':
                total = []
                # while True:
                result = ibm_db.fetch_both(stmt)
                while (result):
                    # print(result)
                    total.append(result)
                    result = ibm_db.fetch_both(stmt)
                    # if result:
                # else:
                # break
                # print('totle',total)
                return total
            else:
                ibm_db.commit(conn)
        except Exception as e:
            print(command + '执行异常:' + str(e))
        finally:
            pass
            pool.getclose(conn)
