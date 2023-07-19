# logstash-output-loki
alternative logstash-output-loki plugin fixed json format problem

inspired by https://github.com/grafana/loki/issues/4863

```"line" => event.get(message_field).to_s```    =>    ```"line" => JSON.generate(event.get(message_field))```
