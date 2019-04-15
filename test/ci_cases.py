from commons import *
from locust import TaskSet
import datetime

curDate = datetime.date.today()
dates = list()

days = 7

for i in range(days):
    dates.append(curDate.strftime("%Y-%m-%d"))
    curDate = curDate - datetime.timedelta(days = 1)

#["2019-04-15", "2019-04-14", "2019-04-13", "2019-04-12", "2019-04-11", "2019-04-10", "2019-04-09"]
print(dates)

def getLatestCreditInquiry(l):
    l.client.get("/aci_api/creditinquiry/latest")

def getCreditInquiryByHash(l):
    l.client.get("/aci_api/creditinquiry/hash/096edfc894eec7740b1391b081ca0a0e47ebd3dcf63f17e3b14ad709c0f403da")

def getCreditInquiryByNonExistHash(l):
    with l.client.get("/aci_api/creditinquiry/hash/" + "1234567", catch_response = True) as response:
        if response.status_code == 404:
            response.success()

def getClassification(l):
    l.client.get("/aci_api/creditinquiry/classification")

def getCreditInquiryList(l):
    payload = {
        'search_type': '0',
        'search_txt': '1',
        'page_size': 100,
        'page': 0,
    }
    l.client.get("/aci_api/creditinquiry/list", params = payload)

def getCreditInquiryListGetEmptyList(l):
    payload = {
        'search_type': '0',
        'search_txt': '12345678',
        'page_size': 100,
        'page': 0,
    }
    l.client.get("/aci_api/creditinquiry/list", params = payload)

def postCreditInquiryTxCountLst(l):
    l.client.post("/aci_api/creditinquiry/tx_count_lst", headers = headers, json = dates)

def postCreditInquiryTxCountLstWithEmptyDates(l):
    with l.client.post("/aci_api/creditinquiry/tx_count_lst", headers = headers, json = [], 
        catch_response = True) as response:
        if response.status_code == 200:
            response.success()

def login(l):
    #l.client.post("/login", {"username":"your_name", "password":"your_pwd"})
    pass

def logout(l):
    #l.client.post("/logout", {"username":"your_name", "password":"your_pwd"})
    pass

class CIBehavior(TaskSet):

    tasks = {
        getLatestCreditInquiry: 1,
        getCreditInquiryByNonExistHash: 1,
        getClassification: 1,
        getCreditInquiryList: 1,
        getCreditInquiryListGetEmptyList: 1,
        postCreditInquiryTxCountLst: 1,
        #postCreditInquiryTxCountLstWithEmptyDates: 1,
    }

    def on_start(self):
        login(self)

    def on_stop(self):
        logout(self)
