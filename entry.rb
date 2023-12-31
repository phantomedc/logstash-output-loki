module Loki
    def to_ns(s)
        (s.to_f * (10**9)).to_i
    end
    class Entry
        include Loki
        attr_reader :labels, :entry
        def initialize(event,message_field,json,logger)
            line = ""
            if json
                begin
                    line = JSON.generate(event.get(message_field))
                rescue => e
                    logger.warn("Error parsing json", :source => message_field, :raw => event.get(message_field), :exception => e)
                end
            else
                line = event.get(message_field).to_s
            end
            @entry = {
                "ts" => to_ns(event.get("@timestamp")),
                "line" => line
            }
            event = event.clone()
            event.remove(message_field)
            event.remove("@timestamp")

            @labels = {}
            event.to_hash.each { |key,value|
                next if key.start_with?('@')
                next if value.is_a?(Hash)
                @labels[key] = value.to_s
            }
        end
    end
end
