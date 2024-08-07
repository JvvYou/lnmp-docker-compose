#!/usr/bin/env python
#-*- coding:utf-8 -*-

import json
import requests,sys
import os
import socket

class dingdingrobot(object):
   def __init__(self,infoContent,phoneNumber,atswitch):
      self.infoContent = infoContent
      self.phoneNumber = phoneNumber
      self.atswitch = atswitch
      self.url='https://oapi.dingtalk.com/robot/send?access_token=xxx'

   def postmarkdown(self):
      data = {}
      data['msgtype'] = 'markdown'
      data['markdown'] = {}
      data['markdown']['title'] = '500'
      data['markdown']['text'] = self.infoContent
      if self.atswitch == '1':
          data['at'] = {}
          data['at']['atMobiles'] = [self.phoneNumber]
          data['at']['isAtAll'] = False
      data = json.dumps(data)
      head = {"Content-Type": "application/json"}
      content = requests.post(self.url, data=data,headers=head)

eNumber = socket.gethostname()
if eNumber != "develop":
    str = "> " + sys.argv[1] + " @" + eNumber
    send = dingdingrobot(str,eNumber,'1')
    send.postmarkdown()
else:
    str = "> " + sys.argv[1]
    send = dingdingrobot(str,'x.x.x.x','0')
    send.postmarkdown()

