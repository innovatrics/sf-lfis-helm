# smartface

![Version: 0.5.1](https://img.shields.io/badge/Version-0.5.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v5_4.23.0](https://img.shields.io/badge/AppVersion-v5_4.23.0-informational?style=flat-square)

SmartFace is a Scalable Facial Recognition Server Platform Able to Process Multiple Real-Time Video Streams. Currently the helm chart supports edge stream and Lightweight Face Identification System (LFIS) deployments

**Homepage:** <https://www.innovatrics.com/face-recognition-solutions/>

## TL;DR

```
helm install smartface oci://ghcr.io/innovatrics/sf-helm/smartface
```

## Prerequisites

The helm chart needs certain objects to be present in the cluster before it can be installed. Refer to `external-config.yaml` for examples for the required objects:

1. [Registry credentials secret](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/#create-a-secret-by-providing-credentials-on-the-command-line)
    - Get the credentials from [Customer portal](https://customerportal.innovatrics.com)
    - The secret name must match `imagePullSecrets` value
    - see comments in `external-config.yaml` for commands to create kubernetes manifest with credentials

1. License file secret
    - Get the license file from [Customer portal](https://customerportal.innovatrics.com)
    - The secret name must match `license.secretName` value
    - see comments in `external-config.yaml` for commands to create kubernetes manifest with license file

1. Optionally [KEDA](https://keda.sh/) for autoscaling
    - see `autoscaling.*` values for more info

## Ingress

By default an ingress object is created with the helm chart. To configure the ingress please see the `ingress.*` values

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| oci://ghcr.io/innovatrics/sf-helm | sf-tenant-operator | 0.2.0 |
| oci://registry-1.docker.io/bitnamicharts | minio | 12.8.15 |
| oci://registry-1.docker.io/bitnamicharts | postgresql | 13.2.1 |
| oci://registry-1.docker.io/bitnamicharts | rabbitmq | 12.0.4 |

All chart dependencies are optional and can be disabled and supplemented with other (for example cloud-based) alternatives

### RabbitMQ
To use non-chart managed rabbitmq:
- set `rabbitmq.enabled=false`
- provide rabbitmq configuration via:
  - supplying values to `rabbitmq.rmqConfiguration` object
  - or creating ConfigMap and setting `rabbitmq.rmqConfiguration.existingConfigMapName`
  - see Sample objects for example
- create Secret with rabbitmq password
  - supply `rabbitmq.existingSecretName` value with name of existing secret
  - see Sample objects for example

#### Sample objects
```
apiVersion: v1
kind: ConfigMap
metadata:
  name: "sf-rmq-connection"
data:
  hostname: "<hostname>"
  username: "<username>"
  port: "5671"
  useSsl: "true"
  streamsPort: "5552"
```

```
apiVersion: v1
kind: Secret
metadata:
  name: "rmq-pass"
stringData:
  rabbitmq-password: "<password>"
```

### S3
To use S3 bucket managed by AWS:
- set `minio.enabled=false`
- provide s3 configuration via:
  - supplying values to `configurations.s3` object
  - or creating ConfigMap and setting `configurations.s3.existingConfigMapName`
  - see Sample objects for example
- When using S3 bucket and running in AWS the authentication can be performed using could-native mechanisms:
  - to authenticate using EC2 instance profile set `configurations.s3.authType` to `InstanceProfile`
  - to authenticate using AssumedRole set `configurations.s3.authType` to `AssumedRole` (useful for example when using [EKS IRSA](https://docs.aws.amazon.com/eks/latest/userguide/iam-roles-for-service-accounts.html))

#### Sample objects
```
apiVersion: v1
kind: ConfigMap
metadata:
  name: "sf-s3-connection"
data:
  name: "smartface"
  region: "eu-central-1"
  folder: "sface"
  authType: "AssumedRole"
  useBucketRegion: "true"
```

### Postgresql
To use externally managed PgSQL instance:
- set `postgresql.enabled=false`
- provide databse configuration:
  - create a Secret - see `external-config.yaml` for example
  - secret name must match `configurations.database.secretName` value
  - key in the Secret must match `configurations.database.connectionStringKey` value
  - see Sample objects for example

#### Sample objects
```
apiVersion: v1
stringData:
  # supply pgsql server connection string - https://learn.microsoft.com/en-us/dotnet/framework/data/adonet/connection-strings
  cs: "Server=<hostname>;Database=<db-name>;Username=<username>;Password=<password>;"
kind: Secret
metadata:
  name: db-cs
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| accessController.annotations | object | `{}` | Annotations for accessController deployment |
| accessController.authContainerPort | int | `5051` |  |
| accessController.authServiceName | string | `"auth-access-controller"` |  |
| accessController.authServicePort | int | `5051` |  |
| accessController.containerPort | int | `80` |  |
| accessController.dnsHost | string | `""` |  |
| accessController.image.digest | string | `nil` | Overrides the image tag with an image digest |
| accessController.image.pullPolicy | string | `"IfNotPresent"` | Docker image pull policy |
| accessController.image.registry | string | `nil` | The Docker registry, overrides `global.image.registry` |
| accessController.image.repository | string | `"innovatrics/smartface/sf-access-controller"` | Docker image repository |
| accessController.image.tag | string | `"v5_1.9.1"` | Access Controller follows different versioning, so the chart app needs to be overridden |
| accessController.name | string | `"access-controller"` |  |
| accessController.nodeSelector | object | `{}` |  |
| accessController.podAnnotations | object | `{}` | Annotations for accessController pods |
| accessController.podLabels | object | `{}` | Additional labels for each accessController pod |
| accessController.resources.requests.cpu | string | `"100m"` |  |
| accessController.resources.requests.memory | string | `"100M"` |  |
| accessController.service.annotations | object | `{}` | Annotations for accessController Service |
| accessController.service.labels | object | `{}` | Additional labels for accessController Service |
| accessController.servicePort | int | `5050` |  |
| accessController.tolerations | list | `[]` |  |
| annotations | object | `{}` | Common annotations for all deployments/StatefulSets |
| api.annotations | object | `{}` | Annotations for api deployment |
| api.containerPort | int | `80` |  |
| api.dnsHost | string | `""` |  |
| api.enabled | bool | `true` |  |
| api.image.digest | string | `nil` | Overrides the image tag with an image digest |
| api.image.pullPolicy | string | `"IfNotPresent"` | Docker image pull policy |
| api.image.registry | string | `nil` | The Docker registry, overrides `global.image.registry` |
| api.image.repository | string | `"innovatrics/smartface/sf-api"` | Docker image repository |
| api.image.tag | string | `nil` | Overrides the image tag whose default is the chart's appVersion |
| api.initMigration | bool | `true` |  |
| api.name | string | `"api"` |  |
| api.nodeSelector | object | `{}` |  |
| api.pdb.create | bool | `false` | create PodDisruptionBudget for api component |
| api.pdb.maxUnavailable | string | `""` |  |
| api.pdb.minAvailable | int | `1` |  |
| api.podAnnotations | object | `{}` | Annotations for api pods |
| api.podLabels | object | `{}` | Additional labels for each api pod |
| api.replicas | int | `1` |  |
| api.resources.limits.memory | string | `"4G"` |  |
| api.resources.requests.cpu | string | `"250m"` |  |
| api.resources.requests.memory | string | `"300M"` |  |
| api.service.annotations | object | `{}` | Annotations for api Service |
| api.service.labels | object | `{}` | Additional labels for api Service |
| api.servicePort | int | `80` |  |
| api.tolerations | list | `[]` |  |
| authApi.annotations | object | `{}` | Annotations for authApi deployment |
| authApi.containerPort | int | `80` |  |
| authApi.dnsHost | string | `""` |  |
| authApi.enabled | bool | `false` |  |
| authApi.image.digest | string | `nil` | Overrides the image tag with an image digest |
| authApi.image.pullPolicy | string | `"IfNotPresent"` | Docker image pull policy |
| authApi.image.registry | string | `nil` | The Docker registry, overrides `global.image.registry` |
| authApi.image.repository | string | `"innovatrics/smartface/sf-api"` | Docker image repository |
| authApi.image.tag | string | `nil` | Overrides the image tag whose default is the chart's appVersion |
| authApi.initMigration | bool | `true` |  |
| authApi.name | string | `"auth-api"` |  |
| authApi.nodeSelector | object | `{}` |  |
| authApi.pdb.create | bool | `false` | create PodDisruptionBudget for authApi component |
| authApi.pdb.maxUnavailable | string | `""` |  |
| authApi.pdb.minAvailable | int | `1` |  |
| authApi.podAnnotations | object | `{}` | Annotations for authApi pods |
| authApi.podLabels | object | `{}` | Additional labels for each authApi pod |
| authApi.replicas | int | `1` | number of replicas to use when autoscaling is not enabled for this component |
| authApi.resources.limits.memory | string | `"4G"` |  |
| authApi.resources.requests.cpu | string | `"250m"` |  |
| authApi.resources.requests.memory | string | `"300M"` |  |
| authApi.service.annotations | object | `{}` | Annotations for authApi Service |
| authApi.service.labels | object | `{}` | Additional labels for authApi Service |
| authApi.servicePort | int | `8098` |  |
| authApi.tolerations | list | `[]` |  |
| autoscaling.api.enabled | bool | `true` | enables ScaledObject for rest API |
| autoscaling.api.maxReplicas | int | `3` |  |
| autoscaling.api.minReplicas | int | `1` |  |
| autoscaling.api.triggers | list | `[]` | provide additional triggers - see https://keda.sh/docs/2.12/concepts/scaling-deployments/#triggers |
| autoscaling.cron.api.nonWorkHoursReplicas | int | `1` |  |
| autoscaling.cron.api.workHoursReplicas | int | `2` |  |
| autoscaling.cron.detector.nonWorkHoursReplicas | int | `1` |  |
| autoscaling.cron.detector.workHoursReplicas | int | `2` |  |
| autoscaling.cron.enabled | bool | `false` | enables predefined workhours-based cron triggers on ScaledObjects |
| autoscaling.cron.extractor.nonWorkHoursReplicas | int | `1` |  |
| autoscaling.cron.extractor.workHoursReplicas | int | `2` |  |
| autoscaling.cron.timezone | string | `"Europe/Bratislava"` | see https://en.wikipedia.org/wiki/List_of_tz_database_time_zones |
| autoscaling.detector.enabled | bool | `true` | enables ScaledObject for detector |
| autoscaling.detector.maxReplicas | int | `3` |  |
| autoscaling.detector.minReplicas | int | `1` |  |
| autoscaling.detector.triggers | list | `[]` | provide additional triggers - see https://keda.sh/docs/2.12/concepts/scaling-deployments/#triggers |
| autoscaling.extractor.enabled | bool | `true` | enables ScaledObject for extractor |
| autoscaling.extractor.maxReplicas | int | `3` |  |
| autoscaling.extractor.minReplicas | int | `1` |  |
| autoscaling.extractor.triggers | list | `[]` | provide additional triggers - see https://keda.sh/docs/2.12/concepts/scaling-deployments/#triggers |
| autoscaling.rmq.api.requestsPerSecond | int | `17` |  |
| autoscaling.rmq.detector.requestsPerSecond | int | `15` |  |
| autoscaling.rmq.enabled | bool | `false` | enables predefined rabbitmq triggers based on requests per second on ScaledObjects |
| autoscaling.rmq.extractor.requestsPerSecond | int | `12` |  |
| autoscaling.rmq.hostSecretName | string | `"rmq-management-uri-with-creds"` |  |
| autoscaling.rmq.triggerAuthName | string | `"keda-trigger-auth-rabbitmq-conn"` |  |
| base.annotations | object | `{}` | Annotations for base deployment |
| base.image.digest | string | `nil` | Overrides the image tag with an image digest |
| base.image.pullPolicy | string | `"IfNotPresent"` | Docker image pull policy |
| base.image.registry | string | `nil` | The Docker registry, overrides `global.image.registry` |
| base.image.repository | string | `"innovatrics/smartface/sf-base"` | Docker image repository |
| base.image.tag | string | `nil` | Overrides the image tag whose default is the chart's appVersion |
| base.name | string | `"base"` |  |
| base.nodeSelector | object | `{}` |  |
| base.podAnnotations | object | `{}` | Annotations for base pods |
| base.podLabels | object | `{}` | Additional labels for each base pod |
| base.resources.requests.cpu | string | `"100m"` |  |
| base.resources.requests.memory | string | `"100M"` |  |
| base.service.annotations | object | `{}` | Annotations for base Service |
| base.service.labels | object | `{}` | Additional labels for base Service |
| base.tolerations | list | `[]` |  |
| base.zmqContainerPort | int | `2406` |  |
| base.zmqServicePort | int | `2406` |  |
| configurations.apiAuth.configName | string | `"auth-config"` | config containing authorization configuration for APIs used when authentication is enabled |
| configurations.database.connectionStringKey | string | `"cs"` | key within the existing secret which contains the connection string, see https://learn.microsoft.com/en-us/dotnet/framework/data/adonet/connection-strings |
| configurations.database.existingSecretName | string | `"db-cs"` | connection string needs to be provided as a dependency of the chart |
| configurations.license.mountPath | string | `"/etc/innovatrics"` |  |
| configurations.license.secretName | string | `"iface-lic"` |  |
| configurations.license.volumeMountName | string | `"license"` |  |
| configurations.s3.authType | string | `"AssumedRole"` | type of authentication to be used. Currently `AssumedRole` and `InstanceProfile` are usable |
| configurations.s3.bucketFolder | string | `""` | prefix (folder) used for S3 objects |
| configurations.s3.bucketName | string | `""` | name of S3 bucket |
| configurations.s3.bucketRegion | string | `""` | system name of AWS region of S3 bucket e.g. `eu-central-1` |
| configurations.s3.existingConfigMapName | string | `""` | supply to bring your own configmap. the configmap needs following keys: `name`, `region`, `folder`, `authType` and `useBucketRegion` |
| configurations.s3.useBucketRegion | bool | `true` | mechanism to resolve bucket endpoint - if `true` then connection is made based on bucket region. If `false` then bucket endpoint needs to be set manually |
| configurations.stationAuth.configName | string | `"station-auth-config"` | config containing authorization configuration for SF Station used when authentication is enabled for SF Station |
| configurations.stationAuth.secretName | string | `"station-client-id"` |  |
| countlyPublisher.annotations | object | `{}` | Annotations for countlyPublisher deployment |
| countlyPublisher.clusterName | string | `""` |  |
| countlyPublisher.enabled | bool | `false` |  |
| countlyPublisher.image.digest | string | `nil` | Overrides the image tag with an image digest |
| countlyPublisher.image.pullPolicy | string | `"IfNotPresent"` | Docker image pull policy |
| countlyPublisher.image.registry | string | `nil` | The Docker registry, overrides `global.image.registry` |
| countlyPublisher.image.repository | string | `"innovatrics/smartface/sf-countly-publisher"` | Docker image repository |
| countlyPublisher.image.tag | string | `"31"` | Countly publisher follows different versioning, so the chart app needs to be overridden |
| countlyPublisher.name | string | `"countly-publisher"` |  |
| countlyPublisher.nodeSelector | object | `{}` |  |
| countlyPublisher.podAnnotations | object | `{}` | Annotations for countlyPublisher pods |
| countlyPublisher.podLabels | object | `{}` | Additional labels for each countlyPublisher pod |
| countlyPublisher.resources.requests.cpu | string | `"100m"` |  |
| countlyPublisher.resources.requests.memory | string | `"100M"` |  |
| countlyPublisher.service.annotations | object | `{}` | Annotations for countlyPublisher Service |
| countlyPublisher.service.labels | object | `{}` | Additional labels for countlyPublisher Service |
| countlyPublisher.tolerations | list | `[]` |  |
| detector.annotations | object | `{}` | Annotations for detector deployment |
| detector.image.digest | string | `nil` | Overrides the image tag with an image digest |
| detector.image.pullPolicy | string | `"IfNotPresent"` | Docker image pull policy |
| detector.image.registry | string | `nil` | The Docker registry, overrides `global.image.registry` |
| detector.image.repository | string | `"innovatrics/smartface/sf-detector"` | Docker image repository |
| detector.image.tag | string | `nil` | Overrides the image tag whose default is the chart's appVersion |
| detector.name | string | `"detector"` |  |
| detector.nodeSelector | object | `{}` |  |
| detector.pdb.create | bool | `false` | create PodDisruptionBudget for detector component |
| detector.pdb.maxUnavailable | string | `""` |  |
| detector.pdb.minAvailable | int | `1` |  |
| detector.podAnnotations | object | `{}` | Annotations for detector pods |
| detector.podLabels | object | `{}` | Additional labels for each detector pod |
| detector.replicas | int | `1` | number of replicas to use when autoscaling is not enabled for this component |
| detector.resources.limits.memory | string | `"1500M"` |  |
| detector.resources.requests.cpu | string | `"750m"` |  |
| detector.resources.requests.memory | string | `"600M"` |  |
| detector.tolerations | list | `[]` |  |
| edgeStreamProcessor.annotations | object | `{}` | Annotations for edgeStreamProcessor deployment |
| edgeStreamProcessor.image.digest | string | `nil` | Overrides the image tag with an image digest |
| edgeStreamProcessor.image.pullPolicy | string | `"IfNotPresent"` | Docker image pull policy |
| edgeStreamProcessor.image.registry | string | `nil` | The Docker registry, overrides `global.image.registry` |
| edgeStreamProcessor.image.repository | string | `"innovatrics/smartface/sf-edge-stream-processor"` | Docker image repository |
| edgeStreamProcessor.image.tag | string | `nil` | Overrides the image tag whose default is the chart's appVersion |
| edgeStreamProcessor.name | string | `"edge-stream-processor"` |  |
| edgeStreamProcessor.nodeSelector | object | `{}` |  |
| edgeStreamProcessor.operationMode.livenessDataStrategy | string | `"ServerOnly"` | Possible values are `EdgeStreamOnly` or `ServerOnly` |
| edgeStreamProcessor.operationMode.matchingDataStrategy | string | `"ServerOnly"` | Possible values are `EdgeStreamOnly` or `ServerOnly` |
| edgeStreamProcessor.pdb.create | bool | `false` | create PodDisruptionBudget for edgeStreamProcessor component |
| edgeStreamProcessor.pdb.maxUnavailable | string | `""` |  |
| edgeStreamProcessor.pdb.minAvailable | int | `1` |  |
| edgeStreamProcessor.podAnnotations | object | `{}` | Annotations for edgeStreamProcessor pods |
| edgeStreamProcessor.podLabels | object | `{}` | Additional labels for each edgeStreamProcessor pod |
| edgeStreamProcessor.replicas | int | `1` |  |
| edgeStreamProcessor.resources.requests.cpu | string | `"100m"` |  |
| edgeStreamProcessor.resources.requests.memory | string | `"100M"` |  |
| edgeStreamProcessor.tolerations | list | `[]` |  |
| edgeStreamsStateSync.annotations | object | `{}` | Annotations for edgeStreamsStateSync deployment |
| edgeStreamsStateSync.image.digest | string | `nil` | Overrides the image tag with an image digest |
| edgeStreamsStateSync.image.pullPolicy | string | `"IfNotPresent"` | Docker image pull policy |
| edgeStreamsStateSync.image.registry | string | `nil` | The Docker registry, overrides `global.image.registry` |
| edgeStreamsStateSync.image.repository | string | `"innovatrics/smartface/sf-edge-streams-state-synchronizer"` | Docker image repository |
| edgeStreamsStateSync.image.tag | string | `nil` | Overrides the image tag whose default is the chart's appVersion |
| edgeStreamsStateSync.name | string | `"edge-streams-state-synchronizer"` |  |
| edgeStreamsStateSync.nodeSelector | object | `{}` |  |
| edgeStreamsStateSync.podAnnotations | object | `{}` | Annotations for edgeStreamsStateSync pods |
| edgeStreamsStateSync.podLabels | object | `{}` | Additional labels for each edgeStreamsStateSync pod |
| edgeStreamsStateSync.resources.requests.cpu | string | `"100m"` |  |
| edgeStreamsStateSync.resources.requests.memory | string | `"100M"` |  |
| edgeStreamsStateSync.tolerations | list | `[]` |  |
| edgeStreamsStateSync.wlStreamPopulationJob.enabled | bool | `false` |  |
| edgeStreamsStateSync.wlStreamPopulationJob.image.digest | string | `nil` | Overrides the image tag with an image digest |
| edgeStreamsStateSync.wlStreamPopulationJob.image.pullPolicy | string | `"IfNotPresent"` | Docker image pull policy |
| edgeStreamsStateSync.wlStreamPopulationJob.image.registry | string | `nil` | The Docker registry, overrides `global.image.registry` |
| edgeStreamsStateSync.wlStreamPopulationJob.image.repository | string | `"innovatrics/smartface/sf-admin"` | Docker image repository |
| edgeStreamsStateSync.wlStreamPopulationJob.image.tag | string | `nil` | Overrides the image tag whose default is the chart's appVersion |
| edgeStreamsStateSync.wlStreamPopulationJob.nodeSelector | object | `{}` |  |
| edgeStreamsStateSync.wlStreamPopulationJob.resources | object | `{}` |  |
| edgeStreamsStateSync.wlStreamPopulationJob.tolerations | list | `[]` |  |
| extractor.annotations | object | `{}` | Annotations for extractor deployment |
| extractor.image.digest | string | `nil` | Overrides the image tag with an image digest |
| extractor.image.pullPolicy | string | `"IfNotPresent"` | Docker image pull policy |
| extractor.image.registry | string | `nil` | The Docker registry, overrides `global.image.registry` |
| extractor.image.repository | string | `"innovatrics/smartface/sf-extractor"` | Docker image repository |
| extractor.image.tag | string | `nil` | Overrides the image tag whose default is the chart's appVersion |
| extractor.name | string | `"extractor"` |  |
| extractor.nodeSelector | object | `{}` |  |
| extractor.pdb.create | bool | `false` | create PodDisruptionBudget for extractor component |
| extractor.pdb.maxUnavailable | string | `""` |  |
| extractor.pdb.minAvailable | int | `1` |  |
| extractor.podAnnotations | object | `{}` | Annotations for extractor pods |
| extractor.podLabels | object | `{}` | Additional labels for each extractor pod |
| extractor.replicas | int | `1` | number of replicas to use when autoscaling is not enabled for this component |
| extractor.resources.limits.memory | string | `"1G"` |  |
| extractor.resources.requests.cpu | string | `"750m"` |  |
| extractor.resources.requests.memory | string | `"500M"` |  |
| extractor.tolerations | list | `[]` |  |
| faceMatcher.annotations | object | `{}` | Annotations for faceMatcher deployment |
| faceMatcher.image.digest | string | `nil` | Overrides the image tag with an image digest |
| faceMatcher.image.pullPolicy | string | `"IfNotPresent"` | Docker image pull policy |
| faceMatcher.image.registry | string | `nil` | The Docker registry, overrides `global.image.registry` |
| faceMatcher.image.repository | string | `"innovatrics/smartface/sf-face-matcher"` | Docker image repository |
| faceMatcher.image.tag | string | `nil` | Overrides the image tag whose default is the chart's appVersion |
| faceMatcher.name | string | `"face-matcher"` |  |
| faceMatcher.nodeSelector | object | `{}` |  |
| faceMatcher.pdb.create | bool | `false` | create PodDisruptionBudget for faceMatcher component |
| faceMatcher.pdb.maxUnavailable | string | `""` |  |
| faceMatcher.pdb.minAvailable | int | `1` |  |
| faceMatcher.podAnnotations | object | `{}` | Annotations for faceMatcher pods |
| faceMatcher.podLabels | object | `{}` | Additional labels for each faceMatcher pod |
| faceMatcher.replicas | int | `1` |  |
| faceMatcher.resources.requests.cpu | string | `"100m"` |  |
| faceMatcher.resources.requests.memory | string | `"100M"` |  |
| faceMatcher.tolerations | list | `[]` |  |
| features.edgeStreams.enabled | bool | `false` |  |
| features.multitenancy.enabled | bool | `false` | enabled for multitenant deployment. Will include sf-tenant-operator subchart if enabled |
| global.image.registry | string | `"registry.gitlab.com"` | Overrides the Docker registry globally for all images |
| graphqlApi.annotations | object | `{}` | Annotations for graphqlApi deployment |
| graphqlApi.containerPort | int | `80` |  |
| graphqlApi.dnsHost | string | `""` |  |
| graphqlApi.enableAuth | bool | `false` |  |
| graphqlApi.enabled | bool | `true` |  |
| graphqlApi.image.digest | string | `nil` | Overrides the image tag with an image digest |
| graphqlApi.image.pullPolicy | string | `"IfNotPresent"` | Docker image pull policy |
| graphqlApi.image.registry | string | `nil` | The Docker registry, overrides `global.image.registry` |
| graphqlApi.image.repository | string | `"innovatrics/smartface/sf-graphql-api"` | Docker image repository |
| graphqlApi.image.tag | string | `nil` | Overrides the image tag whose default is the chart's appVersion |
| graphqlApi.initMigration | bool | `false` |  |
| graphqlApi.name | string | `"graphql-api"` |  |
| graphqlApi.nodeSelector | object | `{}` |  |
| graphqlApi.pdb.create | bool | `false` | create PodDisruptionBudget for graphqlApi component |
| graphqlApi.pdb.maxUnavailable | string | `""` |  |
| graphqlApi.pdb.minAvailable | int | `1` |  |
| graphqlApi.podAnnotations | object | `{}` | Annotations for graphqlApi pods |
| graphqlApi.podLabels | object | `{}` | Additional labels for each graphqlApi pod |
| graphqlApi.replicas | int | `1` |  |
| graphqlApi.resources.limits.memory | string | `"4G"` |  |
| graphqlApi.resources.requests.cpu | string | `"250m"` |  |
| graphqlApi.resources.requests.memory | string | `"300M"` |  |
| graphqlApi.service.annotations | object | `{}` | Annotations for graphqlApi Service |
| graphqlApi.service.labels | object | `{}` | Additional labels for graphqlApi Service |
| graphqlApi.servicePort | int | `8097` |  |
| graphqlApi.tolerations | list | `[]` |  |
| imagePullSecrets | list | `[{"name":"sf-gitlab-registry-creds"}]` | docker secrets used to pull images with |
| ingress.annotations | string | `nil` | supply custom ingress annotation |
| ingress.certificateArn | string | `""` | only used if includeAlbAnnotations == true |
| ingress.class | string | `""` | set ingress class |
| ingress.enabled | bool | `true` | enable creation of ingress object |
| ingress.includeAlbAnnotations | bool | `false` | if enabled then the ingress will include default ALB annotations |
| jaegerTracing.enabled | bool | `true` |  |
| jaegerTracing.hostname | string | `"grafana-agent.monitoring.svc.cluster.local"` |  |
| liveness.annotations | object | `{}` | Annotations for liveness deployment |
| liveness.image.digest | string | `nil` | Overrides the image tag with an image digest |
| liveness.image.pullPolicy | string | `"IfNotPresent"` | Docker image pull policy |
| liveness.image.registry | string | `nil` | The Docker registry, overrides `global.image.registry` |
| liveness.image.repository | string | `"innovatrics/smartface/sf-liveness"` | Docker image repository |
| liveness.image.tag | string | `nil` | Overrides the image tag whose default is the chart's appVersion |
| liveness.name | string | `"liveness"` |  |
| liveness.nodeSelector | object | `{}` |  |
| liveness.pdb.create | bool | `false` | create PodDisruptionBudget for liveness component |
| liveness.pdb.maxUnavailable | string | `""` |  |
| liveness.pdb.minAvailable | int | `1` |  |
| liveness.podAnnotations | object | `{}` | Annotations for liveness pods |
| liveness.podLabels | object | `{}` | Additional labels for each liveness pod |
| liveness.replicas | int | `1` |  |
| liveness.resources.requests.cpu | string | `"750m"` |  |
| liveness.resources.requests.memory | string | `"200M"` |  |
| liveness.tolerations | list | `[]` |  |
| matcher.annotations | object | `{}` | Annotations for matcher deployment |
| matcher.image.digest | string | `nil` | Overrides the image tag with an image digest |
| matcher.image.pullPolicy | string | `"IfNotPresent"` | Docker image pull policy |
| matcher.image.registry | string | `nil` | The Docker registry, overrides `global.image.registry` |
| matcher.image.repository | string | `"innovatrics/smartface/sf-matcher"` | Docker image repository |
| matcher.image.tag | string | `nil` | Overrides the image tag whose default is the chart's appVersion |
| matcher.name | string | `"matcher"` |  |
| matcher.nodeSelector | object | `{}` |  |
| matcher.pdb.create | bool | `false` | create PodDisruptionBudget for matcher component. Only works when `features.multitenancy` is disabled as PDB is not compatible with tenant operator |
| matcher.pdb.maxUnavailable | string | `""` |  |
| matcher.pdb.minAvailable | int | `1` |  |
| matcher.podAnnotations | object | `{}` | Annotations for matcher pods |
| matcher.podLabels | object | `{}` | Additional labels for each matcher pod |
| matcher.replicas | int | `1` |  |
| matcher.resources.requests.cpu | string | `"750m"` |  |
| matcher.resources.requests.memory | string | `"200M"` |  |
| matcher.tolerations | list | `[]` |  |
| metrics.enabled | bool | `false` |  |
| metrics.monitorDiscoveryLabel.instance | string | `"primary"` |  |
| metrics.port | int | `4318` |  |
| metrics.portName | string | `"metrics"` |  |
| metrics.serviceDiscoveryLabels.sf-metrics | string | `"true"` |  |
| migration.enabled | bool | `true` |  |
| migration.initContainer.image.digest | string | `nil` | Overrides the image tag with an image digest |
| migration.initContainer.image.pullPolicy | string | `"IfNotPresent"` | Docker image pull policy |
| migration.initContainer.image.registry | string | `nil` | The Docker registry, overrides `global.image.registry` |
| migration.initContainer.image.repository | string | `"innovatrics/smartface/sf-admin"` | Docker image repository |
| migration.initContainer.image.tag | string | `nil` | Overrides the image tag whose default is the chart's appVersion |
| migration.initContainer.resources | object | `{}` |  |
| minio | object | `{"defaultBuckets":"smartface","enabled":true}` | config for minio subchart, see https://github.com/bitnami/charts/tree/main/bitnami/minio |
| nameOverride | string | `nil` | Overrides the chart's name |
| podAnnotations | object | `{}` | Common annotations for all pods |
| podLabels | object | `{}` | Common labels for all pods |
| postgresql | object | `{"enabled":true,"primary":{"initdb":{"scripts":{"create-database.sql":"CREATE DATABASE smartface"}}}}` | config for postgresql subchart, see https://github.com/bitnami/charts/tree/main/bitnami/postgresql |
| rabbitmq | object | `{"auth":{"erlangCookie":"","existingSecretName":"","password":"","secretKey":"rabbitmq-password","username":"smartface"},"enabled":true,"extraPlugins":"rabbitmq_stream rabbitmq_stream_management rabbitmq_mqtt","mqttConfiguration":{"existingConfigMapName":"","hostname":"","port":1883,"useSsl":false,"username":""},"mqttPublicService":{"enabled":false,"mqttDnsHost":""},"rmqConfiguration":{"existingConfigMapName":"","hostname":"","port":5672,"streamsPort":5552,"useSsl":false,"username":""},"service":{"extraPorts":[{"name":"mqtt","port":1883,"targetPort":1883},{"name":"rmq-stream","port":5552,"targetPort":5552}]}}` | config for rabbitmq subchart, see https://github.com/bitnami/charts/tree/main/bitnami/rabbitmq |
| rabbitmq.auth.erlangCookie | string | `""` | used by subchart |
| rabbitmq.auth.existingSecretName | string | `""` | supply to bring you own secret. The secret needs to contain rabbitmq password under the key with name defined in `rabbitmq.auth.secretKey` |
| rabbitmq.auth.password | string | `""` | used by subchart |
| rabbitmq.auth.secretKey | string | `"rabbitmq-password"` | define key of rabbitmq password in existing/provisioned secret |
| rabbitmq.auth.username | string | `"smartface"` | username of created user in case that `rabbitmq.enabled` is `true` |
| rabbitmq.enabled | bool | `true` | configure if rabbitmq subchart should be included |
| rabbitmq.mqttConfiguration | object | `{"existingConfigMapName":"","hostname":"","port":1883,"useSsl":false,"username":""}` | if rabbitmq subchart is not included, then we need user-supplied configuration to satisfy SmartFace dependency on MQTT broker when `features.edgeStreams.enabled` is `true` |
| rabbitmq.mqttConfiguration.existingConfigMapName | string | `""` | supply to bring your own configmap. The configmap needs following keys: `hostname`, `username`, `port`, and `useSsl`. Other configuration is not used if You provide existing config map. |
| rabbitmq.mqttConfiguration.hostname | string | `""` | hostname of existing MQTT broker |
| rabbitmq.mqttConfiguration.port | int | `1883` | port of existing MQTT broker |
| rabbitmq.mqttConfiguration.useSsl | bool | `false` | set to `true` if existing MQTT broker uses TLS |
| rabbitmq.mqttConfiguration.username | string | `""` | username for existing RabbitMQ instance |
| rabbitmq.mqttPublicService | object | `{"enabled":false,"mqttDnsHost":""}` | service to publicly expose mqtt interface to be used by edge streams. Currently requires ALB controller https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.6/ |
| rabbitmq.rmqConfiguration | object | `{"existingConfigMapName":"","hostname":"","port":5672,"streamsPort":5552,"useSsl":false,"username":""}` | if rabbitmq subchart is not included, then we need user-supplied configuration to satisfy SmartFace dependency on rabbitmq |
| rabbitmq.rmqConfiguration.existingConfigMapName | string | `""` | supply to bring your own configmap. The configmap needs following keys: `hostname`, `username`, `port`, `useSsl`, and optionally `streamsPort` when `features.edgeStreams.enabled` is `true`. Other configuration is not used if You provide existing config map. |
| rabbitmq.rmqConfiguration.hostname | string | `""` | hostname of existing RabbitMQ instance |
| rabbitmq.rmqConfiguration.port | int | `5672` | port of existing RabbitMQ instance |
| rabbitmq.rmqConfiguration.streamsPort | int | `5552` | port for RabbitMQ streams protocol used only when `features.edgeStreams.enabled` is `true` |
| rabbitmq.rmqConfiguration.useSsl | bool | `false` | set to `true` if existing RabbitMQ instance uses TLS |
| rabbitmq.rmqConfiguration.username | string | `""` | username for existing RabbitMQ instance |
| readonlyApi.authName | string | `"readonly-auth-api"` |  |
| readonlyApi.enabled | bool | `false` |  |
| readonlyApi.noAuthName | string | `"readonly-noauth-api"` |  |
| readonlyApi.nodeSelector | object | `{}` |  |
| readonlyApi.proxyContainer.resources | object | `{}` |  |
| readonlyApi.tolerations | list | `[]` |  |
| serviceAccount.annotations | object | `{}` | Annotations for the service account |
| serviceAccount.automountServiceAccountToken | bool | `true` | Set this toggle to false to opt out of automounting API credentials for the service account |
| serviceAccount.create | bool | `true` | Specifies whether a ServiceAccount should be created |
| serviceAccount.imagePullSecrets | list | `[]` | Image pull secrets for the service account |
| serviceAccount.labels | object | `{}` | Labels for the service account |
| serviceAccount.name | string | `"sf-service-account"` | The name of the ServiceAccount to use. |
| serviceAnnotations | object | `{}` | Common annotations for all services |
| serviceLabels | object | `{}` | Common labels for all services |
| sf-tenant-operator | object | `{"config":{"configDir":"/etc/components","fileName":"appsettings.override.json","mapName":"operator-config"},"image":{"secretName":"sf-gitlab-registry-creds"},"installCrd":false}` | configuration for sf-tenant-operator subchart |
| skipLookupBasedValidations | bool | `false` | due to ArgoCD limitations this can be used to skip validations that use the `lookup` helm function - for more information see https://github.com/argoproj/argo-cd/issues/5202 |
| station.annotations | object | `{}` | Annotations for station deployment |
| station.containerPort | int | `80` |  |
| station.dnsHost | string | `""` |  |
| station.enabled | bool | `true` |  |
| station.image.digest | string | `nil` | Overrides the image tag with an image digest |
| station.image.pullPolicy | string | `"IfNotPresent"` | Docker image pull policy |
| station.image.registry | string | `nil` | The Docker registry, overrides `global.image.registry` |
| station.image.repository | string | `"innovatrics/smartface/sf-station"` | Docker image repository |
| station.image.tag | string | `"v5_1.21.0"` | Smartface Station follows different versioning, so the chart app needs to be overridden |
| station.name | string | `"station"` |  |
| station.nodeSelector | object | `{}` |  |
| station.podAnnotations | object | `{}` | Annotations for station pods |
| station.podLabels | object | `{}` | Additional labels for each station pod |
| station.resources.requests.cpu | string | `"100m"` |  |
| station.resources.requests.memory | string | `"100M"` |  |
| station.service.annotations | object | `{}` | Annotations for station Service |
| station.service.labels | object | `{}` | Additional labels for station Service |
| station.servicePort | int | `8000` |  |
| station.tolerations | list | `[]` |  |
| streamDataDbWorker.annotations | object | `{}` | Annotations for streamDataDbWorker deployment |
| streamDataDbWorker.image.digest | string | `nil` | Overrides the image tag with an image digest |
| streamDataDbWorker.image.pullPolicy | string | `"IfNotPresent"` | Docker image pull policy |
| streamDataDbWorker.image.registry | string | `nil` | The Docker registry, overrides `global.image.registry` |
| streamDataDbWorker.image.repository | string | `"innovatrics/smartface/sf-streamdatadbworker"` | Docker image repository |
| streamDataDbWorker.image.tag | string | `nil` | Overrides the image tag whose default is the chart's appVersion |
| streamDataDbWorker.name | string | `"stream-data-db-worker"` |  |
| streamDataDbWorker.nodeSelector | object | `{}` |  |
| streamDataDbWorker.pdb.create | bool | `false` | create PodDisruptionBudget for streamDataDbWorker component |
| streamDataDbWorker.pdb.maxUnavailable | string | `""` |  |
| streamDataDbWorker.pdb.minAvailable | int | `1` |  |
| streamDataDbWorker.podAnnotations | object | `{}` | Annotations for streamDataDbWorker pods |
| streamDataDbWorker.podLabels | object | `{}` | Additional labels for each streamDataDbWorker pod |
| streamDataDbWorker.replicas | int | `1` |  |
| streamDataDbWorker.resources.requests.cpu | string | `"100m"` |  |
| streamDataDbWorker.resources.requests.memory | string | `"100M"` |  |
| streamDataDbWorker.tolerations | list | `[]` |  |

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Innovatrics |  | <https://www.innovatrics.com/> |

## Source Code

* <https://github.com/innovatrics/sf-helm>
* <https://github.com/innovatrics/smartface>

## Breaking changes

### [v0.5.0]
- MinIO subchart is enabled and used by default. To keep using S3 bucket managed outside of this helm chart please set the `minio.enabled` value to `false` and provide configuration details via `configurations.s3`
- Postgresql subchart is enabled and used by default. To keep using PgSQL instance managed outside of this helm chart please set the `postgresql.enabled` value to `false` and provide configuration details via `configurations.database`

### [v0.4.0]
- Changed default behavior for creating S3 configuration. If you like to continue managing the previously created S3 config map please use the `configurations.s3.existingConfigMapName` field. Otherwise the ConfigMap will be managed by the helm chart using the values provided in `configurations.s3`
  - The ConfigMap keys for existing config map are no longer configurable, so if you want to keep using the ConfigMap not managed by this chart then please make sure that the key match what the helm chart expects
- Some values have had their keys changed or moved around:
  - database secret -> value key changed from `configurations.database.secretName` to `configurations.database.existingSecretName`
  - rmq secret values moved to auth parent object -> from `rabbitmq.existingSecretName` to `rabbitmq.auth.existingSecretName` and `rabbitmq.secretKey` to `rabbitmq.auth.secretKey`
  - rmq configuration reworked -> value key `rabbitmq.configMapName` and `rabbitmq.mqttConfigMapName` replaced with `existingConfigMapName` key in `rabbitmq.rmqConfiguration` and `rabbitmq.mqttConfiguration` objects respectively
  - mqtt dns host configuration changed -> value key `rabbitmq.mqttDnsHost` replaced with object with key `rabbitmq.mqttPublicService` that can be disabled
  - deployment selectors changed
  - autoscaling configuration reworked -> moved rmq and cron configuration related to services their respective sub-objects e.g. for detector from `autoscaling.detector` to `autoscaling.cron.detector` and `autoscaling.rmq.detector`
- Deployment label selectors and pod labels were modified to use a more standardized approach. Unfortunately since label selector are immutable and thus the helm release cannot be upgraded. Please first use `helm uninstall` and a fresh `helm install` for upgrading. For more information see the [official documentation](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#label-selector-updates)
