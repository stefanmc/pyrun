#!/usr/local/bin/python
# -*- coding: utf-8 -*-
import ibm_db, time, queue
from tkinter import messagebox
import ibm_db_dbi

class db2pool(object):
    def __init__(self, db, conn_num):
        self.host = db["host"]
        self.port = db["port"]
        self.user = db["uid"]
        self.password = db["password"]
        self.db = db["database"]
        self.conn_num = conn_num
        self.conn_queue = queue.Queue(0)
        self.flag = True
        for i in range(0, self.conn_num):
            try:
                conn = (ibm_db.connect(
                    "DATABASE=" + self.db + ";HOSTNAME=" + self.host + ";PORT=" + self.port + ";PROTOCOL=TCPIP;UID=" + self.user + ";PWD=" + self.password + ";",
                    "", ""))
                self.conn_queue.put(conn)
            except BaseException as e:
                messagebox.showinfo(title='db2连接', message='DB2连接异常'+ str(e))
                self.flag = False
                break

    def getconnect(self):
        for i in range(0, 5):
            if self.conn_queue.qsize() > 0:
                conn = self.conn_queue.get()
                try:
                    stmt = ibm_db.prepare(conn, "select 1 from sysibm.sysdummy1")
                    ibm_db.execute(stmt)
                    return conn
                except BaseException as e:
                    messagebox.showinfo(title='db2连接', message='DB2连接异常'+str(e))
                    try:
                        conn = (ibm_db.connect(
                            "DATABASE=" + self.db + ";HOSTNAME=" + self.host + ";PORT=" + self.port + ";PROTOCOL=TCPIP;UID=" + self.user + ";PWD=" + self.password + ";",
                            "", ""))
                        self.conn_queue.put(conn)
                    except BaseException as e:
                        messagebox.showinfo(title='db2连接', message='DB2连接异常'+ str(e))
                        self.flag = False
                        break
            time.sleep(0.5)

    def getclose(self, conn):
        self.conn_queue.put(conn)

    def connect_dbi(self):
        try:
            conn = (ibm_db_dbi.pconnect(
                "DATABASE=" + self.db + ";HOSTNAME=" + self.host + ";PORT=" + self.port + ";PROTOCOL=TCPIP;UID=" + self.user + ";PWD=" + self.password + ";",
                "", ""))

        except BaseException as e:
            messagebox.showinfo(title='db2连接', message='DB2连接异常'+ str(e))
            self.flag = False

        time.sleep(0.5)


