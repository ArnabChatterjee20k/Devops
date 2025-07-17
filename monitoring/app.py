from flask import Flask, Response, request
import time, random
from prometheus_client import (
    Counter, 
    generate_latest, 
    CONTENT_TYPE_LATEST, 
    CollectorRegistry,
    platform_collector,
    process_collector,
    gc_collector,
    disable_created_metrics
)

app = Flask(__name__)


# Custom registry
registry = CollectorRegistry()

# adding default collectors to the register
gc_collector.GCCollector(registry=registry)
platform_collector.PlatformCollector(registry=registry)
process_collector.ProcessCollector(registry=registry)

# instrumenting metrics
http_requests_count = Counter(
    'http_requests_total',
    'App request count', 
    ['status','path','method'], # labels
    registry=registry)

# for disabling exporting of timestamp with the metri
# disable_created_metrics()

@app.after_request
def after_request(response:Response):
    "incrementing counter after each requests"
    http_requests_count.labels(
        status=str(response.status_code),
        path=request.path,
        method=request.method
    ).inc()
    return response

@app.route('/')
def home():
    return 'hello'

@app.route('/metrics')
def metrics():
    return generate_latest(registry),200,{'Content-Type': CONTENT_TYPE_LATEST}

app.run(host='0.0.0.0',port=5000,debug=True)