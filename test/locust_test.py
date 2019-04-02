from locust import HttpLocust, TaskSet
import json

from ci_cases import *
from rr_cases import *

name = getRandomString()

def login(l):
    #l.client.post("/login", {"username":"your_name", "password":"your_pwd"})
    pass

def logout(l):
    #l.client.post("/logout", {"username":"your_name", "password":"your_pwd"})
    pass

def index(l):
    l.client.get("/index")

def greeting(l):
    l.client.get("/greeting/{}".format(name))

class CIBehavior(TaskSet):

    tasks = {
        index: 1,
        greeting: 1,
        getLatestCreditInquiry: 1,
        getCreditInquiryByNonExistHash: 1,
        getClassification: 1,
        getCreditInquiryList: 1,
        getCreditInquiryListGetEmptyList: 1,
        postCreditInquiryTxCountLst: 1,
        postCreditInquiryTxCountLstWithEmptyDates: 1,
    }

    def on_start(self):
        login(self)

    def on_stop(self):
        logout(self)

class RRBehavior(TaskSet):

    tasks = {

        getLatestRewardRecord: 1,
        getRewardRecordByHash: 1,
        getRewardRecordByNonExistHash: 1,
        getClassification: 1,
        getRewardRecordList: 1,
        getRewardRecordGroupInfo: 1,
    }

    def on_start(self):
        login(self)

    def on_stop(self):
        logout(self)

class CICases(HttpLocust):
    task_set = CIBehavior
    min_wait = 5000
    max_wait = 10000

class RRCases(HttpLocust):
    task_set = RRBehavior
    min_wait = 5000
    max_wait = 10000
