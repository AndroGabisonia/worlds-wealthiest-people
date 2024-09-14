from bs4 import BeautifulSoup
import requests
import pandas as pd

url = 'https://ceoworld.biz/2024/01/12/richest-billionaires-2024/'
response = requests.get(url)

content = BeautifulSoup(response.text, 'html.parser')

table = content.find('table')  # Locate the table
headers = []
rows = []

#Extract headers (if they exist)
if table:
    header_row = table.find('thead')
    if header_row:
        headers = [th.get_text(strip=True) for th in header_row.find_all('th')]

    # Extract the rows
    for row in table.find_all('tr')[1:]:  # Skip header row if headers are used
        cols = [td.get_text(strip=True) for td in row.find_all('td')]
        rows.append(cols)

if headers and rows:
    df = pd.DataFrame(rows, columns=headers)
    df.to_csv('billionaires.csv', index=False, encoding='utf-8')

