.PHONY prometheus grafana

prometheus: prometheus/prometheus.sh
	bash $<

grafana: grafana/grafana.sh
	bash $<