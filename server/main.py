'''
Main file for server
'''

from flask import Flask
from flask_restful import Api
from dotenv import load_dotenv
import os

import endpoints
from ..shared.constants import K

load_dotenv()

app = Flask(__name__)
api = Api(app)

api.add_resource(endpoints.SignIn, '/signin')

if __name__ == '__main__':
  K.api_base
  app.run(debug=(os.environ.get('PYTHON_ENV') == 'dev'))
