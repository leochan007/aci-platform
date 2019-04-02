import random, string

headers = {
    'content-type': 'application/json; charset=utf-8',
}
#'Access-Control-Allow-Headers': 'Authorization,Origin, X-Requested-With, Content-Type, Accept',

def getRandomString():
    return ''.join(random.sample(string.ascii_letters + string.digits, 8))
