# Волков Д. А.
from flask import Flask
import os

app = Flask(__name__)

@app.route('/')
def index():
    return "Hello from KR2"

@app.route('/health')
def health():
    return "ok"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8003)