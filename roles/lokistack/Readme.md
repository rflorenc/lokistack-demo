# Upstream docs

## handle via secret object
https://loki-operator.dev/docs/object_storage.md/#openshift-data-foundation

## handled via configmap in this example
https://loki-operator.dev/docs/api.md/#objectstoragetlsspec a custom CA for accessing ODF

Issues:
https://issues.redhat.com/browse/LOG-2536

# Role details

1. installs odf operator
    ```
    . create storagecluster minimal installation
    . create OBC: details will be needed for loki
    ```

2. installs elasticsearch, clusterlogging and loki operators

3. creates Lokistack configuration
    ```
    . switch to NS
    . create secret with OBC details: logging-loki-s3-secret.yaml
    . create configmap with CA inject bundle annotation: lokistack_ca_configmap.yaml
    . create lokistack: lokistack.yaml
    . create clusterlogging: clusterlogging.yaml
    ```
