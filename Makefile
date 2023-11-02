all: run ingress

run:
	./kind-registry.sh

clean:
	kind delete cluster --name my-kubernetes
	docker stop kind-registry
	docker rm kind-registry

ingress:
	kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

demo:
	kubectl apply -f demo.yaml

post-install-add-insecure-registry:
	# grab the config.toml from the cluster like this:  docker cp kind-control-plane:/etc/containerd/config.toml containerd-config.toml
	# add the contents of the insecure registry snippet: cat config-snippet.toml >> containerd-config.toml
	# copy it back to the workers and the control nodes like so: for i in kind-control-plane kind-worker2 kind-worker kind-worker3; do docker cp config.toml $i:/etc/containerd/config.toml;done
	@# I dunno why the config file exists in 2 directories but again: for i in kind-control-plane kind-worker2 kind-worker kind-worker3; do docker cp config.toml $i:/etc/config.toml;done
	# restart the docker containers with the new config



	