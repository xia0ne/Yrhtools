
import random
import re
import time

import requests


class ProxyHandler(object):
    '''
     ʹ�ô������������Ķ���(������csdn�Ĳ���������Ķ���)
     '''

    def __init__(self):
        self.user_agent_list = [
            "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/22.0.1207.1 Safari/537.1",
            "Mozilla/5.0 (X11; CrOS i686 2268.111.0) AppleWebKit/536.11 (KHTML, like Gecko) Chrome/20.0.1132.57 Safari/536.11",
            "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/536.6 (KHTML, like Gecko) Chrome/20.0.1092.0 Safari/536.6",
            "Mozilla/5.0 (Windows NT 6.2) AppleWebKit/536.6 (KHTML, like Gecko) Chrome/20.0.1090.0 Safari/536.6",
            "Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/19.77.34.5 Safari/537.1",
            "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.9 Safari/536.5",
            "Mozilla/5.0 (Windows NT 6.0) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.36 Safari/536.5",
            "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1063.0 Safari/536.3",
            "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1063.0 Safari/536.3",
            "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_0) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1063.0 Safari/536.3",
            "Mozilla/5.0 (Windows NT 6.2) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1062.0 Safari/536.3",
            "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1062.0 Safari/536.3",
            "Mozilla/5.0 (Windows NT 6.2) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1061.1 Safari/536.3",
            "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1061.1 Safari/536.3",
            "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1061.1 Safari/536.3",
            "Mozilla/5.0 (Windows NT 6.2) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1061.0 Safari/536.3",
            "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.24 (KHTML, like Gecko) Chrome/19.0.1055.1 Safari/535.24",
            "Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/535.24 (KHTML, like Gecko) Chrome/19.0.1055.1 Safari/535.24"
        ]
        # ��ȡ�����ַ����ַ
        self.proxy_get_url = 'http://www.xicidaili.com'
        # Ŀ���ַ
        self.visit_url = 'https://www.avg.cx/index.php/archives/71/'
        # ��ȡ���õĴ�����
        self.proxy_list = []
        # ����ʱʱ��Ϊ3s
        self.timeout = 3

    def get_proxy_list(self):
        '''
        �����õ���Ҫ�Ĵ����б�����
        :return: 
        '''
        # ��self.user_agent_list�����ȡ��һ���ַ���
        UA = random.choice(self.user_agent_list)
        print('���������UA��====%s' % UA)
        headers = {
            'User-Agent': UA
        }
        response = requests.get(url=self.proxy_get_url, headers=headers, timeout=self.timeout)
        html = response.text
        # ��ȡ<td></td>�������������
        list = re.findall(r'<td>(.*?)</td>', html)
        for index in range(int(len(list) / 6)):
            http = list[index * 6 + 3]
            ip = list[index * 6]
            port = list[index * 6 + 1]
            # ���˵�һЩsocket����
            if re.search(r'(HTTP|HTTPS)', http) is None:
                continue
            proxy = '%s://%s:%s' % (http, ip, port)
            self.proxy_list.append(proxy)
        print(self.proxy_list)

    def visit_url_by_proxy_1(self):
        self.get_proxy_list()
        for i in range(len(self.proxy_list)):
            self.visit_url_by_proxy(self.visit_url, self.timeout, self.proxy_list[i], )

    def visit_url_by_proxy(self, url, timeout, proxy=None, num_retries=6, sleep_time=2):
        UA = random.choice(self.user_agent_list)
        http = re.split(r'//', proxy)[0]
        proxies = {
            http: proxy,
        }
        print('���������UA��====%s' % UA)
        headers = {
            'User-Agent': UA
        }
        if proxy == None:  # û��ʹ�ô����ʱ��
            try:
                response = requests.get(url=url, headers=headers, timeout=timeout)
                status_code = response.status_code
                print('��������Ĵ�����====%s,���ص�״̬����===%d' % (proxies, status_code))
            except:
                if num_retries > 0:  ##num_retries�������޶������Դ���
                    time.sleep(sleep_time)  ##�ӳ�ʮ��
                    print('��ȡ��ҳ����10S�󽫻�ȡ�����ڣ�', num_retries, '��')
                    return self.visit_url_by_proxy(url, timeout, num_retries - 1)  ##�������� ����������1
                else:
                    print('��ʼʹ�ô���')
                    time.sleep(sleep_time)
                    proxy = random.choice(self.proxy_list)
                    return self.visit_url_by_proxy(url, timeout, proxy, )  ##����Ϊ�յ�ʱ��
        else:
            try:
                response = requests.get(url=url, headers=headers, proxies=proxies, timeout=timeout)
                status_code = response.status_code
                print('��������Ĵ�����====%s,���ص�״̬����===%d' % (proxies, status_code))
            except:
                if num_retries > 0:
                    time.sleep(sleep_time)
                    proxy = random.choice(self.proxy_list)
                    print(u'���ڸ�������10S�����»�ȡ������', num_retries, u'��')
                    print(u'��ǰ�����ǣ�', proxy)
                    return self.visit_url_by_proxy(url, timeout, proxy, num_retries - 1)
                else:
                    print(u'����Ҳ����ʹ�ˣ�ȡ������')
                    return self.visit_url_by_proxy(url, timeout)


if __name__ == '__main__':
    proxy_handler = ProxyHandler()
    proxy_handler.visit_url_by_proxy_1()
