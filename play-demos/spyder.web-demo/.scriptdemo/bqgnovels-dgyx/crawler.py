from selenium import webdriver
from selenium.webdriver.firefox.service import Service
from selenium.webdriver.firefox.options import Options
from selenium.webdriver.common.keys import Keys
import polars as pl
import os

librewolf_path = 'C:/ProgramFiles/LibreWolf/librewolf.exe'

# 设置 Firefox 选项
options = Options()
options.binary_location = librewolf_path
options.set_preference("general.useragent.override", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36")

# driver.close()
# 创建 Firefox 驱动
driver = webdriver.Firefox(service=Service("E:/bin/geckodriver.exe"), options=options)  # 替换为 geckodriver 的路径
driver.execute_script("Object.defineProperty(navigator, 'webdriver', {get: () => undefined})")

# 你要爬的小说第一章地址
url_base = 'https://somesite.com/book/50416/1'
driver.get(url_base)

nvl_50416 = pl.DataFrame({
    "link": pl.Series(dtype=pl.Utf8),    # 字符串类型
    "title": pl.Series(dtype=pl.Utf8),   # 字符串类型
    "content": pl.Series(dtype=pl.Utf8)  # 字符串类型
})

i = 0
while True:
	i = i+1
	input(f"({i}) Press Enter to continue...")
  # 表里新增一行
  # 这三项要校验效果、以及要根据实际网页情况调整
	newrow = pl.DataFrame({
		"link": [driver.current_url],
		"title": [driver.find_element("tag name", "h1").text],
		"content": [driver.find_element("class name", "text").text]
	})
	print(f"Doing {i}: ")
	print(newrow)
	nvl_50416.extend(newrow)
	print(f"Done {i}. Next ...")
  # 翻页
	driver.find_element("tag name", "body").send_keys(Keys.ARROW_RIGHT)

nvl_50416.write_parquet(r"E:\repos\nvl_50416.parquet")
