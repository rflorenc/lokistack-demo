Docs:
# handle via secret object
https://loki-operator.dev/docs/object_storage.md/#openshift-data-foundation
# handled via configmap in this example
https://loki-operator.dev/docs/api.md/#objectstoragetlsspec a custom CA for accessing ODF

Issues:
https://issues.redhat.com/browse/LOG-2536?


Blog post:
https://cloud.redhat.com/blog/openshift-logging-forwarding-logs-to-external-loki

Procedure:

1. install odf operator
.1 create storagecluster minimal installation
.2 create OBC: details will be needed for loki

2. install elasticsearch, clusterlogging and loki operators

3. create ns openshift-logging
.1 switch to NS
.2 create secret with OBC details: logging-loki-s3-secret.yaml 
.3 create configmap with CA inject bundle annotation: lokistack_ca_configmap.yaml
.4 create lokistack: lokistack.yaml 
.5 create clusterlogging: clusterlogging.yaml

( Accept all webconsole refresh requests )


➜  lokistack-4.10.test git:(master) ✗ oc get pods
NAME                                           READY   STATUS    RESTARTS      AGE
cluster-logging-operator-f57c6b6ff-pzj7t       1/1     Running   0             4h1m
collector-2wqpd                                2/2     Running   0             50m
collector-66hqr                                2/2     Running   0             50m
collector-7x578                                2/2     Running   0             50m
collector-gq6nm                                2/2     Running   0             50m
collector-hkpmk                                2/2     Running   0             50m
collector-kl6sb                                2/2     Running   0             50m
logging-loki-compactor-0                       1/1     Running   0             56m
logging-loki-distributor-65864cd957-g4lvj      1/1     Running   0             56m
logging-loki-gateway-7d486575f8-k5tcd          2/2     Running   1 (56m ago)   56m
logging-loki-index-gateway-0                   1/1     Running   0             56m
logging-loki-ingester-0                        1/1     Running   0             56m
logging-loki-querier-79868b7d87-n87nf          1/1     Running   0             56m
logging-loki-query-frontend-645646bb44-q9srv   1/1     Running   1 (56m ago)   56m
logging-view-plugin-cffd64fb9-4cq8b            1/1     Running   0             51m


# NOTE: all bucket detail fields have to be base64 encoded
➜  lokistack-4.10.test git:(master) ✗ oc get secret logging-loki-s3 -o yaml
apiVersion: v1
data:
  access_key_id: YmFDSkZjTmFrS0FsZ0huVDRva3UK
  access_key_secret: TGl6ckJRWnQ1eGY1SGFpTGRockdMYkM2NjZBaTNhSjNFaGRROGZvZQo=
  bucketnames: bG9raS1kZDRlMGRjOC1kYWRkLTQ3NDktYmVlOC1hMjk0Nzc4ZjA4YTMK
  endpoint: aHR0cHM6Ly9zMy5vcGVuc2hpZnQtc3RvcmFnZS5zdmMK
kind: Secret
metadata:
  name: ...
  namespace: openshift-logging


➜  lokistack-4.10.test git:(master) ✗ oc get csv
NAME                           DISPLAY                            VERSION   REPLACES   PHASE
cluster-logging.5.5.1          Red Hat OpenShift Logging          5.5.1                Succeeded
elasticsearch-operator.5.5.1   OpenShift Elasticsearch Operator   5.5.1                Succeeded
loki-operator.5.5.1            Loki Operator                      5.5.1                Succeeded
