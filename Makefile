
play:
	docker play kube --replace=true compose.yaml

run-release:
	docker exec sim-rs-app /opt/antithesis/test/v1/simple_release/singleton_driver_simulate.sh

run-debug:
	docker exec sim-rs-app /opt/antithesis/test/v1/simple_release/singleton_driver_simulate.sh

push:
	docker push docker.io/bwbush/sim-rs-antithesis:latest

docker: Dockerfile sim-rs entrypoint.py libvoidstar.so config.yaml network.yaml singleton_release.sh singleton_debug.sh
	docker build -f $< -t docker.io/bwbush/sim-rs-antithesis .

clean:
	rm -r sim-rs config.yaml network.yaml

sim-rs: ../sim-rs
	cp -Lr $< .

libvoidstar.so:
	wget https://antithesis.com/assets/instrumentation/libvoidstar.so

config.yaml: ../analysis/sims/cip/experiments/config.yaml
	cp $< $@

network.yaml: ../data/simulation/pseudo-mainnet/topology-v2.yaml
	cp $< $@

.phony: docker push play run-release run-debug clean
