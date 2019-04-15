from locust import HttpLocust, TaskSet
import json

from ci_cases import *
from rr_cases import *

name = getRandomString()

lc_min_wait = 5000
lc_max_wait = 20000

def index(l):
    l.client.get("/index")

def greeting(l):
    l.client.get("/greeting/{}".format(name))

class CommonBehavior(TaskSet):

    tasks = {
        index: 1,
        greeting: 1,
    }

class CommonCases(HttpLocust):
    task_set = CommonBehavior
    min_wait = lc_min_wait
    max_wait = lc_max_wait

class CICases(HttpLocust):
    task_set = CIBehavior
    min_wait = lc_min_wait
    max_wait = lc_max_wait

class RRCases(HttpLocust):
    task_set = RRBehavior
    min_wait = lc_min_wait
    max_wait = lc_max_wait
