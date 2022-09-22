# Installs baseline LokiStack for demo purposes

## Prerequisites

Python and make.

## Requirements

See `requirements.txt`.

## Install

```bash
export sc=${example}

make
```

## Manual install

```bash
oc login https://api.cluster.example.net:6443 --token=${token}

$ ansible-playbook site.yaml -v -e "sc=${example}" -e is_prod=false
```

## Notes

* Any http_proxy configuration will have to be done manually, either for pip configuration or access to an internal registry.

The following env vars can be exported while testing the playbooks manually.

```bash
K8S_AUTH_VERIFY_SSL=False
K8S_AUTH_API_KEY={{ openshift_token }}
K8S_AUTH_HOST={{ https://openshift_api_url:6443 }}
```
