{{- define "rybbit.clickhouse.name" -}}
{{- default "clickhouse" .Values.clickhouse.nameOverride }}
{{- end}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "rybbit.clickhouse.fullname" -}}
    {{- if .Values.clickhouse.fullnameOverride }}
        {{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
        {{- else }}
        {{- $name := include "rybbit.name" . }}
        {{- $clickhouseName := include "rybbit.clickhouse.name" . }}
        {{- printf "%s-%s" $name $clickhouseName | trunc 63 | trimSuffix "-" }}
    {{- end }}
{{- end }}

{{/*
Create a default fully qualified pvc name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "rybbit.clickhouse.pvcName" -}}
    {{- $name := include "rybbit.clickhouse.fullname" . }}
    {{- printf "%s-%s" $name "data" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "rybbit.clickhouse.labels" -}}
helm.sh/chart: {{ include "rybbit.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{ include "rybbit.clickhouse.selectorLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "rybbit.clickhouse.selectorLabels" -}}
app.kubernetes.io/name: {{ include "rybbit.clickhouse.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
