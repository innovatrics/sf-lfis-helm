# Changelog

## [v0.8.10]

### Changed

- Fixed an issue that prevented the palm feature from being disabled when features.palms.enabled was set to false

## [v0.8.9]

### Added

- Added palm feature

### Changed

- Version of SmartFace Platform to 4.29.0
- Version of SmartFace Station to 1.29

## [v0.8.8]

### Changed

- Added extractionAlgorithm and compatibilityVersion for face templates

## [v0.8.7]

### Changed

- Version of SmartFace Platform to 4.28.2
- Version of SmartFace Station to 1.28
- Version of Countly publisher to 45

## [v0.8.6]

### Added

- Added configuration options for specifying arbitrary environment variables.
- Added configurable settings to define working hours, non-working hours, and weekends for time-based scaling.
- Made `warmupDetectionAlgorithms` configurable for the detector component.

## [v0.8.5]

### Added

- Added support for offline video processing functionality

### Changed

- The default value for access control spoof check is set to false.

## [v0.8.4]

### Added

- Add configuration settings to define and manage labels for watchlist members.
- Implement additional configurations to strengthen and refine access control mechanisms.

### Changed

- Bumped version of SmartFace Platform to 4.28.1

## [v0.8.3]

### Added

- Added support for Access Controller to publish notification messages through MQTT broker
- Added relayController service to be able to trigger onprem mqtt relay
- Added qr functionality

### Changed

- Bumped version of SmartFace Station to 1.27.0
- Bumped version of SmartFace Platform to 4.28.0
- Bumped version of Access Controller to 1.13.0

## [v0.8.2]

### Changed

- Bumped version of SmartFace Station to 1.26.0
- Bumped version of SmartFace Platform to 4.27.0
- Bumped version of Access Controller to 1.12.0

## [v0.8.1]

### Added

- Support for skipping WLStream migration during the migration process
- Support for reducing number of published metrics

## [v0.8.0]

### Added

- Added test pods supporting `helm test` command
  - There are multiple test pods, some of which run based on what is possible to test in the selected chart configuration
- Added support for tenant management API (ingress)
- Deployment revisionHistoryLimit and updateStrategy are configurable via values
- Access Controller MQTT settings are configurable via values

### Changed

- Bumped version of SmartFace Station to 1.25.1
- Bumped version of SmartFace Platform to 4.26.0
- Bumped version of Access Controller to 1.11.0
- Bumped version of `sf-tenant-management` subchart
  - since the chart was renamed all references to previous name were changes

### Breaking change

- Changed default behavior for creating Authentication configuration. If you like to continue managing the previously created Authentication config map please use the `configurations.apiAuth.existingConfigMapName` field. Otherwise the ConfigMap will be managed by the helm chart using the values provided in `configurations.apiAuth`
  - This change also includes renaming previous field `configurations.apiAuth.configName` -> `configurations.apiAuth.existingConfigMapName`

## [v0.7.1]

### Changed

- Fixed condition for DbSynchronizationLeader deployment

## [v0.7.0]

### Added

- Support for DbSynchronizationLeader has been added

### Changed

- Bumped version of sf-tenant-operator to 0.3.0

## [v0.6.0]

### Changed

- Bumped version of SmartFace Station to 1.22

### Breaking change

- deployment of SmartFace Station is now disabled by default. To reenable previous behavior with deploying SmartFace Station please set the `station.enabled` value to `true`.
  - previous behavior with enabled SmartFace Station caused the installation of helm chart with default values to fail on validation because SmartFace Station is currently dependant on SmartFace API with enabled authentication, which in turn requires the existence of external authentication provider and correct configuration of relevant SmartFace services

## [v0.5.2]

### Changed

- Bumped version of SmartFace Platform to 4.24

## [v0.5.1]

### Changed

- Bumped version of SmartFace Platform and SmartFace Station

## [v0.5.0]

### Added

- Support for using [minio subchart](https://github.com/bitnami/charts/tree/main/bitnami/minio) in place of S3 bucket
  - This is now default behavior of the helm chart
- Support for using [postgresql subchart](https://github.com/bitnami/charts/tree/main/bitnami/postgresql) in place of externally managed PgSQL instance
  - This is now default behavior of the helm chart

### Breaking change

- MinIO subchart is enabled and used by default. To keep using S3 bucket managed outside of this helm chart please set the `minio.enabled` value to `false` and provide configuration details via `configurations.s3`
- Postgresql subchart is enabled and used by default. To keep using PgSQL instance managed outside of this helm chart please set the `postgresql.enabled` value to `false` and provide configuration details via `configurations.database`

## [v0.4.0]

### Added

- Common labels with option to specify custom labels/annotation for objects
- PodDisruptionBudgets for deployments that can be scaled
- Support for custom KEDA triggers
- Existing configmap for rabbitMQ and S3 is no longer necessary and the chart can create them from provided values, which is also the new default behavior for S3

### Breaking change

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

## [v0.3.0]

### Added

- Support for pushing watchlist data to edge streams via EdgeStreamsStateSynchronizer

## [v0.2.0]

### Added

- Initial implementation
- Chart can be configured to support following scenarios:
  - Lightweight Face Identification System (LFIS) - single-tenant and multi-tenant
  - Edge stream processing - single tenant only
- Chart can be configured to use externally-managed rabbitmq (e.g. [AmazonMQ](https://aws.amazon.com/amazon-mq/)) or deploy a rabbitmq [subchart](https://github.com/bitnami/charts/tree/main/bitnami/rabbitmq)
