This is a Helm chart to run Kubernetes in virtual machines on KubeVirt in Kubernetes.

You can use it to easily get test environments from your running Kubernetes cluster.

It requires KubeVirt and CDI (Containerized Data Importer).

# Examples

```
# Default settings: 1 control, 1 worker, load-balance the API with haproxy
helm install kubekubevirt oci://ghcr.io/remram44/kubekubevirt --namespace virtual-k8s

# No haproxy, connect to control node directly
helm install kubekubevirt oci://ghcr.io/remram44/kubekubevirt --namespace virtual-k8s --set haproxy.enabled=false --set worker.count=2

# More control nodes
helm install kubekubevirt oci://ghcr.io/remram44/kubekubevirt --namespace virtual-k8s --set controlPlane.count=3 --set worker.count=2
```

# See also

[vcluster](https://github.com/loft-sh/vcluster) lets you run Kubernetes in Kubernetes, however it runs pods as pods on the outer cluster. This means that, while you get a fully isolated control-plane (scheduling, namespaces, DNS), you run on the same container runtime and are subject to the outer cluster's capabilities and policies.
