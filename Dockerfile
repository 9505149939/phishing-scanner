FROM python:3.10

# Install dependencies
RUN apt-get update && apt-get install -y \ 
    curl unzip gnupg ca-certificates fonts-liberation libappindicator3-1 \ 
    libasound2 libatk-bridge2.0-0 libatk1.0-0 libcups2 libdbus-1-3 libgdk-pixbuf2.0-0 \ 
    libnspr4 libnss3 libx11-xcb1 libxcomposite1 libxdamage1 libxrandr2 \ 
    xdg-utils libgbm1 libgtk-3-0 wget && \ 
    rm -rf /var/lib/apt/lists/*

# Add Chrome key and repo
RUN curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/google-linux-keyring.gpg &&     echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-linux-keyring.gpg] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list

# Install Chrome
RUN apt-get update && apt-get install -y google-chrome-stable

# Install Python packages
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app files
COPY phishing_model.py /app/phishing_model.py
COPY runner.py /app/runner.py
WORKDIR /app
ENTRYPOINT ["python", "runner.py"]