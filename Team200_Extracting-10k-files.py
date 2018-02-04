import csv
import urllib2    
from collections import defaultdict
import time
from urllib import FancyURLopener  # This is library that helps us create the headless browser
from random import choice #This library helps pick a random item from a list
import pandas as pd
import string 

weblinks = []
company = []
date_of_filing =[]
ticker_symbol = []
company_sector =[]
columns = defaultdict(list) 
with open('SP_500.csv') as f:
    reader = csv.DictReader(f) 
    for row in reader: 
        for (k,v) in row.items(): 
            columns[k].append(v) 

ticker_symbol = (columns['Ticker symbol'])
company =(columns['Company Name'])
company_sector = (columns['GICS Sector'])
date_of_filing =(columns['Date of filing'])
weblinks =(columns['weblink'])



user_agents = [
    'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36',
    'Opera/9.80 (X11; Linux i686; Ubuntu/14.10) Presto/2.12.388 Version/12.16',
    'Mozilla/5.0 (Windows; U; Windows NT 6.1; rv:2.2) Gecko/20110201',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_3) AppleWebKit/537.75.14 (KHTML, like Gecko) Version/7.0.3 Safari/7046A194A',
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/12.246'
]


urls = []
for links in weblinks[0:]:
    
    class MyOpener(FancyURLopener, object):
        version = choice(user_agents)
    
    myopener = MyOpener()
    page=myopener.open(links)    
    html = page.read()
    
    index = html.find('<table class="tableFile"')
    start = html.find('<a href="/Archives/edgar/data')
    stop = html.find('.htm</a>')
    html_link = html[start+9:stop+4]
    stop_link = html_link.find('.htm">')
    final_link = html_link[:stop_link+4]

    urls.append("https://www.sec.gov" + final_link)
    print urls

df_out = pd.DataFrame({'Ticker Symbol': ticker_symbol,'Company Name': company,'GICS Sector': company_sector,'Date of filing': date_of_filing,'HTML Links': urls})
df_out.to_csv('Extracting-10k-files.csv',index = False)




