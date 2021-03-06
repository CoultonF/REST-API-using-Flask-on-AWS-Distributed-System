MK=minikube
KC=kubectl
IC=istioctl


# these might need to change
CLUSTER=minikube
NS=cmpt756t3
CTX=minikube
DRIVER=virtualbox

# developed and tested again 1.19.2
KVER=1.19.2

start-mk:
	$(MK) start --kubernetes-version=$(KVER) | tee mk-cluster.log
	$(KC) config use-context $(CTX) | tee mk-reinstate.log
	$(KC) create ns $(NS) | tee -a mk-reinstate.log
	$(KC) config set-context $(CTX) --namespace=$(NS) | tee -a mk-reinstate.log
	$(KC) label ns $(NS) istio-injection=enabled | tee -a mk-reinstate.log
	$(IC) install --set profile=demo | tee -a mk-reinstate.log
	$(KC) -n istio-system get service istio-ingressgateway -o=custom-columns=EXTERNAL-IP:.status.loadBalancer.ingress[0].ip | sed -n 2p | tee ../../API/external-ip.log

start-ubuntu-mk:
	$(MK) start --kubernetes-version=$(KVER) | tee mk-cluster.log
	echo 'Enter 192.168.99.110 and then 192.168.99.120'
	$(MK) addons configure metallb
	$(MK) addons enable metallb
	$(KC) config use-context $(CTX) | tee mk-reinstate.log
	$(KC) create ns $(NS) | tee -a mk-reinstate.log
	$(KC) config set-context $(CTX) --namespace=$(NS) | tee -a mk-reinstate.log
	$(KC) label ns $(NS) istio-injection=enabled | tee -a mk-reinstate.log
	$(IC) install --set profile=demo | tee -a mk-reinstate.log
	$(KC) -n istio-system get service istio-ingressgateway -o=custom-columns=EXTERNAL-IP:.status.loadBalancer.ingress[0].ip | sed -n 2p | tee ../../API/external-ip.log
stop: showcontext
	$(MK) stop | tee mk-stop.log

delete: showcontext clean
	$(MK) delete | tee mk-delete.log

# output: mk-status.log
status: showcontext
	$(MK) status | tee mk-status.log

# start up Minikube's nice dashboard
dashboard:
	$(MK) dashboard

# show svc inside istsio's ingressgateway
extern: showcontext
	$(KC) -n istio-system get svc istio-ingressgateway

# start up a tunnel to allow traffic into your cluster
lb: showcontext
	$(MK) tunnel

# switch to the cmpt756e4 context quickly
cd:
	$(KC) config use-context $(CTX)

# show svc across all namespaces
lsa: showcontext
	$(KC) get svc --all-namespaces

# show deploy and pods in current ns; svc of cmpt756e4 ns
ls: showcontext
	$(KC) get gw,deployments,pods
	$(KC) -n $(NS) get svc

# show containers across all pods
# output mk-pods.txt
lsd:
	$(KC) get pods --all-namespaces -o=jsonpath='{range .items[*]}{"\n"}{.metadata.name}{":\t"}{range .spec.containers[*]}{.image}{", "}{end}{end}' | sort | tee mk-pods.txt

# reinstate all the pieces of istio on a new cluster
# do this whenever you restart your cluster
# output: mk-reinstate.log
reinstate:
	$(KC) config use-context $(CTX) | tee mk-reinstate.log
	$(KC) create ns $(NS) | tee -a mk-reinstate.log
	$(KC) config set-context $(CTX) --namespace=$(NS) | tee -a mk-reinstate.log
	$(KC) label ns $(NS) istio-injection=enabled | tee -a mk-reinstate.log
	$(IC) install --set profile=demo | tee -a mk-reinstate.log

# show contexts available
showcontext:
	$(KC) config get-contexts

clean:
	rm -f {mk-cluster,mk-status,mk-delete,mk-stop}.log
