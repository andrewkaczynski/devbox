# devbox

![Version: 1.1](https://img.shields.io/badge/Version-1.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.1](https://img.shields.io/badge/AppVersion-1.1-informational?style=flat-square)

A Helm chart for devbox installation

## Installation

Example:

```bash
cd deploy/charts/devbox
helm install devbox .
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| extraArgs | list | `[]` |  |
| extraConfigmapMounts | list | `[]` |  |
| extraContainers | string | `""` |  |
| extraInitContainers | string | `""` |  |
| extraPorts | list | `[]` |  |
| extraSecretMounts | list | `[]` |  |
| extraVars | list | `[]` |  |
| extraVolumeMounts | list | `[]` |  |
| fullnameOverride | string | `""` |  |
| hostnameOverride | string | `""` |  |
| image.pullPolicy | string | `"Always"` |  |
| image.repository | string | `"andrewkaczynski/devbox"` |  |
| image.tag | string | `"1.1"` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.enabled | bool | `false` |  |
| ingress.ingressClassName | string | `""` |  |
| lifecycle.enabled | bool | `false` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| persistence.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.annotations | object | `{}` |  |
| persistence.enabled | bool | `true` |  |
| persistence.size | string | `"10Gi"` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| priorityClassName | string | `""` |  |
| replicaCount | int | `1` |  |
| resources | object | `{}` |  |
| securityContext.enabled | bool | `true` |  |
| securityContext.fsGroup | int | `1000` |  |
| securityContext.runAsUser | int | `1000` |  |
| service.port | int | `8080` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| tolerations | list | `[]` |  |
| volumePermissions.enabled | bool | `true` |  |
| volumePermissions.image.repository | string | `"andrewkaczynski/devbox"` |  |
| volumePermissions.image.tag | string | `"1.1"` |  |
| volumePermissions.securityContext.runAsUser | int | `0` |  |

----------------------------------------------
