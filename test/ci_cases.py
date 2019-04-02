from commons import *

import datetime

curDate = datetime.date.today()
dates = list()

days = 7

for i in range(days):
    dates.append(curDate.strftime("%Y-%m-%d"))
    curDate = curDate - datetime.timedelta(days = 1)

def getLatestCreditInquiry(l):
    l.client.get("/creditinquiry/latest")

def getCreditInquiryByHash(l):
    l.client.get("/creditinquiry/hash/096edfc894eec7740b1391b081ca0a0e47ebd3dcf63f17e3b14ad709c0f403da")

def getCreditInquiryByNonExistHash(l):
    with l.client.get("/creditinquiry/hash/" + "1234567", catch_response = True) as response:
        if response.status_code == 404:
            response.success()

def getClassification(l):
    l.client.get("/creditinquiry/classification")

def getCreditInquiryList(l):
    payload = {
        'search_type': '0',
        'search_txt': '1',
        'page_size': 100,
        'page': 0,
    }
    l.client.get("/creditinquiry/list", params = payload)

def getCreditInquiryListGetEmptyList(l):
    payload = {
        'search_type': '0',
        'search_txt': '12345678',
        'page_size': 100,
        'page': 0,
    }
    l.client.get("/creditinquiry/list", params = payload)

def postCreditInquiryTxCountLst(l):
    l.client.post("/creditinquiry/tx_count_lst", headers = headers, json = dates)

def postCreditInquiryTxCountLstWithEmptyDates(l):
    with l.client.post("/creditinquiry/tx_count_lst", headers = headers, json = [], 
        catch_response = True) as response:
        if response.status_code == 200:
            response.success()