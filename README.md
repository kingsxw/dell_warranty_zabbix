# dell_warranty_zabbix
DELL warrany days Left monitoring for ZABBIX Via the lastest oauth v2 & eapi v5

## follow the steps:

- Request an Warranty API key from DELL TechDirect, this may take couple days to be approved.


- Place dell_info.sh to external scripts directory of Your ZABBIX Server/Proxy 


  Don't forget to chmod +x dell_info.sh, and yum -y install jq
  
- import the template file, change value of {$DELL_WARRANTY_API_KEY} and {$DELL_WARRANTY_KEY_SECRET} to which you get from DELL


- In my discovery rule:

  Host name = IP Address
  
  Visible name = SNMPv2 agent "SNMPv2-MIB::sysName.0", like idrac-xxxxxxx in default.
  
  So I send Visible name ({HOST.NAME}) to dell_info.sh and remove idrac- to get service tag via service_tag=$(echo $3| cut -d"-" -f2)
  
  You can make changes to fit your cast
  
  For example get service tag directoty via snmpwalk -v2c -c COMMUNITY IDRAC_IP SNMPv2-MIB::sysName.0 and then cut -d"-" -f2
  
 
#### Only NBD and POW is included in my template. 
#### If need other ones, just clone and modify. :)
