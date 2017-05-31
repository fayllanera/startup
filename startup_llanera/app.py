from flask import Flask, jsonify, request
from flask.ext.httpauth import HTTPBasicAuth
import sys, flask
import model

app = Flask(__name__)
auth = HTTPBasicAuth()

def spcall(qry, param, commit=False):
    try:
        dbo = model.DBconn()
        cursor = dbo.getcursor()
        cursor.callproc(qry, param)
        res = cursor.fetchall()
        if commit:
            dbo.dbcommit()
        return res
    except:
        res = [("Error: " + str(sys.exc_info()[0]) + " " + str(sys.exc_info()[1]),)]
    return res

@auth.get_password
def getpassword(username):
    return 'akolagini'

@app.route('/login/', methods=['POST'])
def login():

    params = request.get_json()
    password = params["password"]
    email = params["email"]

    res = spcall('login', (email,password), True)
    print res
    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'error'})

    return jsonify({'status': 'ok'})

@app.route('/data', methods=['POST', 'GET'])
def data_post():
    text = request.data
    return text

@app.after_request
def add_cors(resp):
    resp.headers['Access-Control-Allow-Origin'] = flask.request.headers.get('Origin', '*')
    resp.headers['Access-Control-Allow-Credentials'] = True
    resp.headers['Access-Control-Allow-Methods'] = 'POST, OPTIONS, GET, PUT, DELETE'
    resp.headers['Access-Control-Allow-Headers'] = flask.request.headers.get('Access-Control-Request-Headers',
                                                                             'Authorization')
    # set low for debugging

    if app.debug:
        resp.headers["Access-Control-Max-Age"] = '1'
    return resp

if __name__=='__main__':
    app.run(debug=True)