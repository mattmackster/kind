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


	