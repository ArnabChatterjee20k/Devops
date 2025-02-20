from flask import Flask
import redis
import os

uri = os.environ.get("URI")
r = redis.Redis.from_url(uri)

app = Flask(__name__)

@app.get("/")
def home():
	return "home 1brew1"

@app.get("/test")
def hello():
	import random
	r.set("test",random.randint(1,10))
	return str(int(r.get("test")))

app.run(host="0.0.0.0",debug=True)
