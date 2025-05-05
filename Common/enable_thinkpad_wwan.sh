#Turns on Quectel Wireless Solutions Co., Ltd. EM120R-GL LTE Modem
sudo mbimcli -d /dev/wwan0mbim0 -p -v --quectel-set-radio-state=ON
