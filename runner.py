import time
from selenium import webdriver
import undetected_chromedriver as uc
from phishing_model import classify_urls

target_url = "https://example.com"

options = uc.ChromeOptions()
options.add_argument('--headless')
options.add_argument('--no-sandbox')
options.add_argument('--disable-dev-shm-usage')
driver = uc.Chrome(options=options)

driver.get(target_url)
time.sleep(5)
links = [a.get_attribute('href') for a in driver.find_elements("tag name", "a")]
driver.quit()

urls = [link for link in links if link]
results = classify_urls(urls)

print("\nPhishing URL Predictions:")
for url, score in zip(urls, results):
    print(f"{url} => Score: {score}")