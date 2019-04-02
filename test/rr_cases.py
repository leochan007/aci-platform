from commons import *

import datetime

def getLatestRewardRecord(l):
    l.client.get("/rewardrecord/latest")

def getRewardRecordByHash(l):
    l.client.get("/rewardrecord/hash/40f9a5252323f3a439c195b891f9abef5ee3537498e40e2a713fd30638e328fa")

def getRewardRecordByNonExistHash(l):
    with l.client.get("/rewardrecord/hash/" + "1234567", catch_response = True) as response:
        if response.status_code == 404:
            response.success()

def getClassification(l):
    l.client.get("/rewardrecord/classification")

def getRewardRecordList(l):
    payload = {
        'search_type': '6',
        'search_txt': '拉新王',
        'page_size': 100,
        'page': 0,
    }
    l.client.get("/rewardrecord/list", params = payload)

def getRewardRecordGroupInfo(l):
    payload = {
        'activity_type': '拉新王',
    }
    l.client.get("/creditinquiry/list", params = payload)
