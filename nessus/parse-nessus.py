#!/bin/python

# nessus_parser import parse_nessus_file, parse_nessus_xml

import xml.etree.ElementTree as ET

import os
import sys
import re

results = {}
descs = {}

commap = {}

def process_file(filename):

    tree = ET.parse(filename)
    root = tree.getroot()
    
    host_ip=''

    for rep in root.findall('Report'):
        #print('report name '+rep.attrib['name'])
        
        for host in rep.findall('ReportHost'):
            backup_ip=host.attrib['name']
            for hp in host.findall('HostProperties'):
                for tag in hp.findall('tag'):
                    #print(tag.attrib['name'], tag.text)
                    tn=tag.attrib['name']
                    if tn == 'host-fqdn':
                        fqdn=tag.text
                    if tn == 'host-ip':
                        host_ip=tag.text

                    for ri in host.findall('ReportItem'):
                        port=ri.attrib['port']
                        family=ri.attrib['pluginFamily']
                        sev=ri.attrib['severity']
                        pid=ri.attrib['pluginID']
                        pname=ri.attrib['pluginName']
                        
                        #print('host '+host_ip+' '+ri.attrib['port'])

                        if host_ip=='':
                            host_ip=backup_ip

                        if host_ip=='':
                            continue

                        desc = ri.find('description').text
                        
                        if family=='Policy Compliance':
                            if not re.search('PASSED',desc):
                                m=re.search('"([^:]+)" :',desc)
#                                print(desc)
                                try:
                                    pname=m.group(1)
                                except:
                                    noop=1
                                    #print("match failed")
 
                        if True or family!='Policy Compliance':
                            if int(sev)>0:
                                # build tables
                            
                                entry=host_ip+':'+port

                                # issue name is key, add IP:port to dict
                            
                                if pname in results:
                                    if entry not in results[pname]:
                                        results[pname].append(entry)
                                else:
                                    results[pname]=[entry]
                                    descs[pname]=desc
                                                            
            
directory = sys.argv[1]

for filename in os.listdir(directory):
    if filename.endswith(".nessus")                            : 
        process_file(os.path.join(directory, filename))
        continue
    else:
        continue

#iterate over results
for hostkey in results:
    print('*************************')
    print('Issue '+hostkey)
    print('Desc '+descs[hostkey])
    for host in results[hostkey]:
        print(host)
    print()



