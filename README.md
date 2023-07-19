# logstash-output-loki
alternative logstash-output-loki plugin fixed json format problem

inspired by https://github.com/grafana/loki/issues/4863

```"line" => event.get(message_field).to_s```    =>    ```"line" => JSON.generate(event.get(message_field))```

```
output{
  url => "http://loki:3100/loki/api/v1/push"
  json => true
}
```
