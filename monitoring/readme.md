# Monitoring with prometheus and grafana

* Prometheus -> Monitoring system
* Grafana -> visualisatoin and dashboard tool

### using prometheus client in python
* By default, Prometheus uses a global registry that automatically includes standard Python runtime and process-level metrics

* To disable them we need to create custom registry and use the registry

### server and client
* We dont need prom server to genreate metrics. Prom client is sufficent for generating the metrics in the backend

* To send the metrics to the prom server -> each instrumented target(backend) must provide a `/metrics` endpoint (or similar) where you can see all the collected metrics and their current values.

* for the server see the docker compose file

* server just scrapes the metrics endpoint to get the metrics and this configuration is set in the `prometheus.yml`

* for multiple backends we can set multiple targets in the target in the config

### Instrumenting metrics
* "Instrumenting" means adding code to your application to collect metrics

* Adding metrics objects (like Counter, Gauge, Histogram, Summary)

* Placing .inc(), .observe(), etc., at meaningful parts of your code

* http_requests_total{method="GET", code="200"} 1234
    * http_requests_total -> metric name
    * {method="GET", code="200"} -> labels
    * 1234 -> value

### About prometheus
In Prometheus, each metric has a name, optional labels, and a value that changes over time. There are four core metric types:

* Counter: Counts things that go up but never down, like the number of requests served or errors encountered.

* Gauge: Measures values that can go up or down, such as CPU usage, memory available, etc.

* Histogram: Tracks the distribution of values over time to help you understand the typical, average, and outlier values.

* Summary: Similar to histograms, but focuses on precomputed percentiles for a single instance of an application.


### Metrics best practices
- Counters & Up-Down Counters
    - these allow you to record a delta without knowing the previous value
    - Examples:
        - every time a new HTTP request comes in, the counter is increased by 1
        - every time a Websocket connection is opened, the counter is increased by 1, every time it closes, it’s decreased by 1
- Histograms
    - these sample incoming records into buckets and return an aggregated view of the data
    - Example: HTTP response size or HTTP request time
        - we are not interested in every HTTP response size or request time, but instead want to know an aggregated view of the data in a given span
        - Histograms aggregate data into buckets, this allows us to pick the avg, p90, p95 or p99 percentile
- Gauges
    - these are similar to Histograms, but do not pre-aggregate data
    - Gauges are helpful when the recorded amount of data is predictable (e.g. data gets collected every 10s)
    - a current example: Swoole worker pool stats

Important: Every combination of key-value label creates it’s own time series. This is called cardinality. It’s critical to avoid high-cardinality metrics. Do not store projectIds, userIds, raw request uri or other dynamic values as label values. This will cause the metric system to explode. A rule of thumb is that you should be able to read out all the possible values. 