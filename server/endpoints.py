'''
Module including API endpoints for use by clients
'''
from flask_restful import Resource

class SignIn(Resource):
  '''
  Sign In
  '''
  def get(self):
    '''
    Get
    '''
    return {'data': 'Hi'}
