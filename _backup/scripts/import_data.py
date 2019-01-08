# -*- coding: utf-8 -*-

from alphacar.mongo_wrapper import MongoWrapper

import datetime

import os

import json, yaml

from optparse import OptionParser

from decimal import *

import pymongo

import copy

import hashlib

if __name__ == "__main__":
    import sys
    import io
    defaultencoding = 'utf-8'
    if sys.getdefaultencoding() != defaultencoding:
        print('---reload(sys)---')
        reload(sys)
        sys.setdefaultencoding(defaultencoding)
    sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')

    print('---iov demo---')

    parser = OptionParser()
    parser.add_option("-r", "--recreate", action = "store_true", default = False, dest = "recreate")
    parser.add_option("-n", "--nostore", action = "store_true", default = False, dest = "nostore")

    (options, args) = parser.parse_args()

    filePath = os.path.dirname(__file__)
    fileNamePath = os.path.split(os.path.realpath(__file__))[0]
    yamlPath = os.path.join(fileNamePath, './conf/config.yaml')

    conf = None

    with open(yamlPath, "r", encoding='utf-8') as f:
        tmp = f.read()
        conf = yaml.load(tmp)

    mongo_wrapper = MongoWrapper(conf['mongo'])

    db_name = conf['mongo']['db_name']
    username = conf['mongo']['username']
    password = conf['mongo']['password']

    print('options.nostore:', options.nostore)
    print('options.recreate:', options.recreate)

    today = datetime.datetime.today()
    today_str = today.strftime('%Y-%m-%d')

    if options.recreate == True:
        mongo_wrapper.drop_database(db_name)
    mongo_wrapper.connect_db(db_name, username, password)

    print('today_str:', today_str)

    datas = None

    with open('sample.json', "r", encoding='utf-8') as f:
        #data = f.read()
        #datas = json.loads(data, encoding="gbk")
        datas = json.load(f, encoding="utf-8")

    collection = 'credit_inquiry'

    mongo_wrapper.create_index(collection, [('hash', pymongo.ASCENDING)], True)

    for data in datas:

        dumps_str = json.dumps(data, ensure_ascii = False)

        print(dumps_str)

        sha_algo= hashlib.sha256()
        sha_algo.update(dumps_str.encode("utf8"))

        hashVal = sha_algo.hexdigest()

        tmp_data = copy.deepcopy(data)

        tmp_data['hash'] = hashVal

        mongo_wrapper.insert_data(collection, tmp_data)

        if options.nostore:
            continue

    res = mongo_wrapper.db[collection].find({})

    #for item in res:
    #    print (item)

    mongo_wrapper.close()
