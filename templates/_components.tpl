{{/*
api
*/}}
{{/*
Template used for resolving SF api name
*/}}
{{- define "smartface.api.name" }}
{{- $prefix := include "smartface.name" . -}}
{{- $suffix := .Values.api.name -}}
{{- printf "%s-%s" $prefix $suffix -}}
{{- end -}}

{{/*
Template used for resolving labels for api component
*/}}
{{- define "smartface.api.labels" }}
{{- include "smartface.labels" . }}
app.kubernetes.io/component: "api"
{{- end -}}

{{/*
Template used for resolving selector labels for api component
*/}}
{{- define "smartface.api.selectorLabels" }}
{{- include "smartface.selectorLabels" . }}
app.kubernetes.io/component: "api"
{{- end -}}

{{/*
authApi
*/}}
{{/*
Template used for resolving SF authApi name
*/}}
{{- define "smartface.authApi.name" }}
{{- $prefix := include "smartface.name" . -}}
{{- $suffix := .Values.authApi.name -}}
{{- printf "%s-%s" $prefix $suffix -}}
{{- end -}}

{{/*
Template used for resolving labels for authApi component
*/}}
{{- define "smartface.authApi.labels" }}
{{- include "smartface.labels" . }}
app.kubernetes.io/component: "authApi"
{{- end -}}

{{/*
Template used for resolving selector labels for authApi component
*/}}
{{- define "smartface.authApi.selectorLabels" }}
{{- include "smartface.selectorLabels" . }}
app.kubernetes.io/component: "authApi"
{{- end -}}

{{/*
graphqlApi
*/}}
{{/*
Template used for resolving SF graphqlApi name
*/}}
{{- define "smartface.graphqlApi.name" }}
{{- $prefix := include "smartface.name" . -}}
{{- $suffix := .Values.graphqlApi.name -}}
{{- printf "%s-%s" $prefix $suffix -}}
{{- end -}}

{{/*
Template used for resolving labels for graphqlApi component
*/}}
{{- define "smartface.graphqlApi.labels" }}
{{- include "smartface.labels" . }}
app.kubernetes.io/component: "graphqlApi"
{{- end -}}

{{/*
Template used for resolving selector labels for graphqlApi component
*/}}
{{- define "smartface.graphqlApi.selectorLabels" }}
{{- include "smartface.selectorLabels" . }}
app.kubernetes.io/component: "graphqlApi"
{{- end -}}

{{/*
relayController
*/}}
{{/*
Template used for resolving SF relayController name
*/}}
{{- define "smartface.relayController.name" }}
{{- $prefix := include "smartface.name" . -}}
{{- $suffix := .Values.relayController.name -}}
{{- printf "%s-%s" $prefix $suffix -}}
{{- end -}}

{{/*
Template used for resolving labels for relayController component
*/}}
{{- define "smartface.relayController.labels" }}
{{- include "smartface.labels" . }}
app.kubernetes.io/component: "relayController"
{{- end -}}

{{/*
Template used for resolving selector labels for relayController component
*/}}
{{- define "smartface.relayController.selectorLabels" }}
{{- include "smartface.selectorLabels" . }}
app.kubernetes.io/component: "relayController"
{{- end -}}

{{/*
dbSynchronizationLeader
*/}}
{{/*
Template used for resolving SF dbSynchronizationLeader name
*/}}
{{- define "smartface.dbSynchronizationLeader.name" }}
{{- $prefix := include "smartface.name" . -}}
{{- $suffix := .Values.dbSynchronizationLeader.name -}}
{{- printf "%s-%s" $prefix $suffix -}}
{{- end -}}

{{/*
Template used for resolving labels for dbSynchronizationLeader component
*/}}
{{- define "smartface.dbSynchronizationLeader.labels" }}
{{- include "smartface.labels" . }}
app.kubernetes.io/component: "dbSynchronizationLeader"
{{- end -}}

{{/*
Template used for resolving selector labels for dbSynchronizationLeader component
*/}}
{{- define "smartface.dbSynchronizationLeader.selectorLabels" }}
{{- include "smartface.selectorLabels" . }}
app.kubernetes.io/component: "dbSynchronizationLeader"
{{- end -}}

{{/*
detector
*/}}
{{/*
Template used for resolving SF detector name
*/}}
{{- define "smartface.detector.name" }}
{{- $prefix := include "smartface.name" . -}}
{{- $suffix := .Values.detector.name -}}
{{- printf "%s-%s" $prefix $suffix -}}
{{- end -}}

{{/*
Template used for resolving labels for detector component
*/}}
{{- define "smartface.detector.labels" }}
{{- include "smartface.labels" . }}
app.kubernetes.io/component: "detector"
{{- end -}}

{{/*
Template used for resolving selector labels for detector component
*/}}
{{- define "smartface.detector.selectorLabels" }}
{{- include "smartface.selectorLabels" . }}
app.kubernetes.io/component: "detector"
{{- end -}}

{{/*
objectDetector
*/}}
{{/*
Template used for resolving SF objectDetector name
*/}}
{{- define "smartface.objectDetector.name" }}
{{- $prefix := include "smartface.name" . -}}
{{- $suffix := .Values.objectDetector.name -}}
{{- printf "%s-%s" $prefix $suffix -}}
{{- end -}}

{{/*
Template used for resolving labels for objectDetector component
*/}}
{{- define "smartface.objectDetector.labels" }}
{{- include "smartface.labels" . }}
app.kubernetes.io/component: "objectDetector"
{{- end -}}

{{/*
Template used for resolving selector labels for objectDetector component
*/}}
{{- define "smartface.objectDetector.selectorLabels" }}
{{- include "smartface.selectorLabels" . }}
app.kubernetes.io/component: "objectDetector"
{{- end -}}

{{/*
extractor
*/}}
{{/*
Template used for resolving SF extractor name
*/}}
{{- define "smartface.extractor.name" }}
{{- $prefix := include "smartface.name" . -}}
{{- $suffix := .Values.extractor.name -}}
{{- printf "%s-%s" $prefix $suffix -}}
{{- end -}}

{{/*
Template used for resolving labels for extractor component
*/}}
{{- define "smartface.extractor.labels" }}
{{- include "smartface.labels" . }}
app.kubernetes.io/component: "extractor"
{{- end -}}

{{/*
Template used for resolving selector labels for extractor component
*/}}
{{- define "smartface.extractor.selectorLabels" }}
{{- include "smartface.selectorLabels" . }}
app.kubernetes.io/component: "extractor"
{{- end -}}

{{/*
matcher
*/}}
{{/*
Template used for resolving SF matcher name
*/}}
{{- define "smartface.matcher.name" }}
{{- $prefix := include "smartface.name" . -}}
{{- $suffix := .Values.matcher.name -}}
{{- printf "%s-%s" $prefix $suffix -}}
{{- end -}}

{{/*
Template used for resolving labels for matcher component
*/}}
{{- define "smartface.matcher.labels" }}
{{- include "smartface.labels" . }}
app.kubernetes.io/component: "matcher"
{{- end -}}

{{/*
Template used for resolving selector labels for matcher component
*/}}
{{- define "smartface.matcher.selectorLabels" }}
{{- include "smartface.selectorLabels" . }}
app.kubernetes.io/component: "matcher"
{{- end -}}

{{/*
liveness
*/}}
{{/*
Template used for resolving SF liveness name
*/}}
{{- define "smartface.liveness.name" }}
{{- $prefix := include "smartface.name" . -}}
{{- $suffix := .Values.liveness.name -}}
{{- printf "%s-%s" $prefix $suffix -}}
{{- end -}}

{{/*
Template used for resolving labels for liveness component
*/}}
{{- define "smartface.liveness.labels" }}
{{- include "smartface.labels" . }}
app.kubernetes.io/component: "liveness"
{{- end -}}

{{/*
Template used for resolving selector labels for liveness component
*/}}
{{- define "smartface.liveness.selectorLabels" }}
{{- include "smartface.selectorLabels" . }}
app.kubernetes.io/component: "liveness"
{{- end -}}

{{/*
edgeStreamProcessor
*/}}
{{/*
Template used for resolving SF edgeStreamProcessor name
*/}}
{{- define "smartface.edgeStreamProcessor.name" }}
{{- $prefix := include "smartface.name" . -}}
{{- $suffix := .Values.edgeStreamProcessor.name -}}
{{- printf "%s-%s" $prefix $suffix -}}
{{- end -}}

{{/*
Template used for resolving labels for edgeStreamProcessor component
*/}}
{{- define "smartface.edgeStreamProcessor.labels" }}
{{- include "smartface.labels" . }}
app.kubernetes.io/component: "edgeStreamProcessor"
{{- end -}}

{{/*
Template used for resolving selector labels for edgeStreamProcessor component
*/}}
{{- define "smartface.edgeStreamProcessor.selectorLabels" }}
{{- include "smartface.selectorLabels" . }}
app.kubernetes.io/component: "edgeStreamProcessor"
{{- end -}}

{{/*
edgeStreamsStateSync
*/}}
{{/*
Template used for resolving SF edgeStreamsStateSync name
*/}}
{{- define "smartface.edgeStreamsStateSync.name" }}
{{- $prefix := include "smartface.name" . -}}
{{- $suffix := .Values.edgeStreamsStateSync.name -}}
{{- printf "%s-%s" $prefix $suffix -}}
{{- end -}}

{{/*
Template used for resolving labels for edgeStreamsStateSync component
*/}}
{{- define "smartface.edgeStreamsStateSync.labels" }}
{{- include "smartface.labels" . }}
app.kubernetes.io/component: "edgeStreamsStateSync"
{{- end -}}

{{/*
Template used for resolving selector labels for edgeStreamsStateSync component
*/}}
{{- define "smartface.edgeStreamsStateSync.selectorLabels" }}
{{- include "smartface.selectorLabels" . }}
app.kubernetes.io/component: "edgeStreamsStateSync"
{{- end -}}

{{/*
base
*/}}
{{/*
Template used for resolving SF base name
*/}}
{{- define "smartface.base.name" }}
{{- $prefix := include "smartface.name" . -}}
{{- $suffix := .Values.base.name -}}
{{- printf "%s-%s" $prefix $suffix -}}
{{- end -}}

{{/*
Template used for resolving labels for base component
*/}}
{{- define "smartface.base.labels" }}
{{- include "smartface.labels" . }}
app.kubernetes.io/component: "base"
{{- end -}}

{{/*
Template used for resolving selector labels for base component
*/}}
{{- define "smartface.base.selectorLabels" }}
{{- include "smartface.selectorLabels" . }}
app.kubernetes.io/component: "base"
{{- end -}}

{{/*
faceMatcher
*/}}
{{/*
Template used for resolving SF faceMatcher name
*/}}
{{- define "smartface.faceMatcher.name" }}
{{- $prefix := include "smartface.name" . -}}
{{- $suffix := .Values.faceMatcher.name -}}
{{- printf "%s-%s" $prefix $suffix -}}
{{- end -}}

{{/*
Template used for resolving labels for faceMatcher component
*/}}
{{- define "smartface.faceMatcher.labels" }}
{{- include "smartface.labels" . }}
app.kubernetes.io/component: "faceMatcher"
{{- end -}}

{{/*
Template used for resolving selector labels for faceMatcher component
*/}}
{{- define "smartface.faceMatcher.selectorLabels" }}
{{- include "smartface.selectorLabels" . }}
app.kubernetes.io/component: "faceMatcher"
{{- end -}}

{{/*
accessController
*/}}
{{/*
Template used for resolving SF accessController name
*/}}
{{- define "smartface.accessController.name" }}
{{- $prefix := include "smartface.name" . -}}
{{- $suffix := .Values.accessController.name -}}
{{- printf "%s-%s" $prefix $suffix -}}
{{- end -}}

{{/*
accessController auth
*/}}
{{/*
Template used for resolving SF accessController name
*/}}
{{- define "smartface.accessController.authServiceName" }}
{{- $prefix := include "smartface.name" . -}}
{{- $suffix := .Values.accessController.authServiceName -}}
{{- printf "%s-%s" $prefix $suffix -}}
{{- end -}}


{{/*
Template used for resolving labels for accessController component
*/}}
{{- define "smartface.accessController.labels" }}
{{- include "smartface.labels" . }}
app.kubernetes.io/component: "accessController"
{{- end -}}

{{/*
Template used for resolving selector labels for accessController component
*/}}
{{- define "smartface.accessController.selectorLabels" }}
{{- include "smartface.selectorLabels" . }}
app.kubernetes.io/component: "accessController"
{{- end -}}

{{/*
station
*/}}
{{/*
Template used for resolving SF station name
*/}}
{{- define "smartface.station.name" }}
{{- $prefix := include "smartface.name" . -}}
{{- $suffix := .Values.station.name -}}
{{- printf "%s-%s" $prefix $suffix -}}
{{- end -}}

{{/*
Template used for resolving labels for station component
*/}}
{{- define "smartface.station.labels" }}
{{- include "smartface.labels" . }}
app.kubernetes.io/component: "station"
{{- end -}}

{{/*
Template used for resolving selector labels for station component
*/}}
{{- define "smartface.station.selectorLabels" }}
{{- include "smartface.selectorLabels" . }}
app.kubernetes.io/component: "station"
{{- end -}}

{{/*
streamDataDbWorker
*/}}
{{/*
Template used for resolving SF streamDataDbWorker name
*/}}
{{- define "smartface.streamDataDbWorker.name" }}
{{- $prefix := include "smartface.name" . -}}
{{- $suffix := .Values.streamDataDbWorker.name -}}
{{- printf "%s-%s" $prefix $suffix -}}
{{- end -}}

{{/*
Template used for resolving labels for streamDataDbWorker component
*/}}
{{- define "smartface.streamDataDbWorker.labels" }}
{{- include "smartface.labels" . }}
app.kubernetes.io/component: "streamDataDbWorker"
{{- end -}}

{{/*
Template used for resolving selector labels for streamDataDbWorker component
*/}}
{{- define "smartface.streamDataDbWorker.selectorLabels" }}
{{- include "smartface.selectorLabels" . }}
app.kubernetes.io/component: "streamDataDbWorker"
{{- end -}}

{{/*
VideoAggregator
*/}}
{{/*
Template used for resolving VideoAggregator name
*/}}
{{- define "smartface.VideoAggregator.name" }}
{{- $prefix := include "smartface.name" . -}}
{{- $suffix := .Values.VideoAggregator.name -}}
{{- printf "%s-%s" $prefix $suffix -}}
{{- end -}}

{{/*
Template used for resolving labels for VideoAggregator component
*/}}
{{- define "smartface.VideoAggregator.labels" }}
{{- include "smartface.labels" . }}
app.kubernetes.io/component: "VideoAggregator"
{{- end -}}

{{/*
Template used for resolving selector labels for VideoAggregator component
*/}}
{{- define "smartface.VideoAggregator.selectorLabels" }}
{{- include "smartface.selectorLabels" . }}
app.kubernetes.io/component: "VideoAggregator"
{{- end -}}

{{/*
VideoCollector
*/}}
{{/*
Template used for resolving VideoCollector name
*/}}
{{- define "smartface.VideoCollector.name" }}
{{- $prefix := include "smartface.name" . -}}
{{- $suffix := .Values.VideoCollector.name -}}
{{- printf "%s-%s" $prefix $suffix -}}
{{- end -}}

{{/*
Template used for resolving labels for VideoCollector component
*/}}
{{- define "smartface.VideoCollector.labels" }}
{{- include "smartface.labels" . }}
app.kubernetes.io/component: "VideoCollector"
{{- end -}}

{{/*
Template used for resolving selector labels for VideoCollector component
*/}}
{{- define "smartface.VideoCollector.selectorLabels" }}
{{- include "smartface.selectorLabels" . }}
app.kubernetes.io/component: "VideoCollector"
{{- end -}}


{{/*
VideoReader
*/}}
{{/*
Template used for resolving VideoReader name
*/}}
{{- define "smartface.VideoReader.name" }}
{{- $prefix := include "smartface.name" . -}}
{{- $suffix := .Values.VideoReader.name -}}
{{- printf "%s-%s" $prefix $suffix -}}
{{- end -}}

{{/*
Template used for resolving labels for VideoReader component
*/}}
{{- define "smartface.VideoReader.labels" }}
{{- include "smartface.labels" . }}
app.kubernetes.io/component: "VideoReader"
{{- end -}}

{{/*
Template used for resolving selector labels for VideoReader component
*/}}
{{- define "smartface.VideoReader.selectorLabels" }}
{{- include "smartface.selectorLabels" . }}
app.kubernetes.io/component: "VideoReader"
{{- end -}}

{{/*
[palm detector]
*/}}
{{/*
Template used for resolving palm detector name
*/}}
{{- define "smartface.palmDetector.name" }}
{{- $prefix := include "smartface.name" . -}}
{{- $suffix := .Values.palmDetector.name -}}
{{- printf "%s-%s" $prefix $suffix -}}
{{- end -}}

{{/*
Template used for resolving labels for palm detector component
*/}}
{{- define "smartface.palmDetector.labels" }}
{{- include "smartface.labels" . }}
app.kubernetes.io/component: "palmDetector"
{{- end -}}

{{/*
Template used for resolving selector labels for palm detector component
*/}}
{{- define "smartface.palmDetector.selectorLabels" }}
{{- include "smartface.selectorLabels" . }}
app.kubernetes.io/component: "palmDetector"
{{- end -}}

{{/*
[palm extractor]
*/}}
{{/*
Template used for resolving palm extractor name
*/}}
{{- define "smartface.palmExtractor.name" }}
{{- $prefix := include "smartface.name" . -}}
{{- $suffix := .Values.palmExtractor.name -}}
{{- printf "%s-%s" $prefix $suffix -}}
{{- end -}}

{{/*
Template used for resolving labels for palm extractor component
*/}}
{{- define "smartface.palmExtractor.labels" }}
{{- include "smartface.labels" . }}
app.kubernetes.io/component: "palmExtractor"
{{- end -}}

{{/*
Template used for resolving selector labels for palm extractor component
*/}}
{{- define "smartface.palmExtractor.selectorLabels" }}
{{- include "smartface.selectorLabels" . }}
app.kubernetes.io/component: "palmExtractor"
{{- end -}}

{{/*
countlyPublisher
*/}}
{{/*
Template used for resolving SF countlyPublisher name
*/}}
{{- define "smartface.countlyPublisher.name" }}
{{- $prefix := include "smartface.name" . -}}
{{- $suffix := .Values.countlyPublisher.name -}}
{{- printf "%s-%s" $prefix $suffix -}}
{{- end -}}

{{/*
Template used for resolving labels for countlyPublisher component
*/}}
{{- define "smartface.countlyPublisher.labels" }}
{{- include "smartface.labels" . }}
app.kubernetes.io/component: "countlyPublisher"
{{- end -}}

{{/*
Template used for resolving selector labels for countlyPublisher component
*/}}
{{- define "smartface.countlyPublisher.selectorLabels" }}
{{- include "smartface.selectorLabels" . }}
app.kubernetes.io/component: "countlyPublisher"
{{- end -}}

{{/*
RabbitMq
*/}}

{{/*
Template used for resolving RabbitMQ config map name
*/}}
{{- define "smartface.rabbitmq.name" }}
{{- $prefix := include "smartface.name" . -}}
{{- $suffix := "rabbitmq" -}}
{{- printf "%s-%s" $prefix $suffix -}}
{{- end -}}

{{/*
Template used for resolving mqtt config map name
*/}}
{{- define "smartface.rabbitmq.mqttName" }}
{{- $prefix := include "smartface.name" . -}}
{{- $suffix := "mqtt" -}}
{{- printf "%s-%s" $prefix $suffix -}}
{{- end -}}

{{/*
S3
*/}}

{{/*
Template used for resolving S3 config map name
*/}}
{{- define "smartface.s3.name" }}
{{- $prefix := include "smartface.name" . -}}
{{- $suffix := "s3" -}}
{{- printf "%s-%s" $prefix $suffix -}}
{{- end -}}

{{/*
Template used for resolving Auth config map name
*/}}
{{- define "smartface.auth.name" }}
{{- $prefix := include "smartface.name" . -}}
{{- $suffix := "auth" -}}
{{- printf "%s-%s" $prefix $suffix -}}
{{- end -}}

{{/*
Tests
*/}}

{{/*
Template used for resolving Watchlist tests name
*/}}
{{- define "smartface.watchlistTests.name" }}
{{- $prefix := include "smartface.name" . -}}
{{- $suffix := "watchlist-tests" -}}
{{- printf "%s-%s" $prefix $suffix -}}
{{- end -}}

{{/*
Template used for resolving Watchlist tests with authentication name
*/}}
{{- define "smartface.authWatchlistTests.name" }}
{{- $prefix := include "smartface.name" . -}}
{{- $suffix := "watchlist-auth-tests" -}}
{{- printf "%s-%s" $prefix $suffix -}}
{{- end -}}

{{/*
Template used for resolving Edge Stream tests name
*/}}
{{- define "smartface.edgeStreamTests.name" }}
{{- $prefix := include "smartface.name" . -}}
{{- $suffix := "edge-stream-tests" -}}
{{- printf "%s-%s" $prefix $suffix -}}
{{- end -}}

{{/*
Template used for resolving GraphQL tests name
*/}}
{{- define "smartface.graphQlTests.name" }}
{{- $prefix := include "smartface.name" . -}}
{{- $suffix := "graphql-tests" -}}
{{- printf "%s-%s" $prefix $suffix -}}
{{- end -}}

{{/*
Template used for resolving Multitenant tests name
*/}}
{{- define "smartface.multitenantTests.name" }}
{{- $prefix := include "smartface.name" . -}}
{{- $suffix := "multitenant-tests" -}}
{{- printf "%s-%s" $prefix $suffix -}}
{{- end -}}
