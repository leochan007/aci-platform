from commons import *
from locust import TaskSet
import datetime

def getLatestRewardRecord(l):
    l.client.get("/aci_api/rewardrecord/latest")

def getRewardRecordByHash(l):
    l.client.get("/aci_api/rewardrecord/hash/40f9a5252323f3a439c195b891f9abef5ee3537498e40e2a713fd30638e328fa")

def getRewardRecordByNonExistHash(l):
    with l.client.get("/aci_api/rewardrecord/hash/" + "1234567", catch_response = True) as response:
        if response.status_code == 404:
            response.success()

def getClassification(l):
    l.client.get("/aci_api/rewardrecord/classification")

def getRewardRecordList(l):
    payload = {
        'search_type': '6',
        'search_txt': '拉新王',
        'page_size': 100,
        'page': 0,
    }
    l.client.get("/aci_api/rewardrecord/list", params = payload)

def getRewardRecordGroupInfo(l):
    payload = {
        'activity_type': '拉新王',
    }
    l.client.get("/aci_api/creditinquiry/list", params = payload)

def login(l):
    #l.client.post("/login", {"username":"your_name", "password":"your_pwd"})
    pass

def logout(l):
    #l.client.post("/logout", {"username":"your_name", "password":"your_pwd"})
    pass

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
