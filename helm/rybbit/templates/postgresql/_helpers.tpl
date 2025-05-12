{{- define "rybbit.postgresql.name" -}}
{{- default "postgresql" .Values.postgresql.nameOverride }}
{{- end}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "rybbit.postgresql.fullname" -}}
    {{- if .Values.postgresql.fullnameOverride }}
        {{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
        {{- else }}
        {{- $name := include "rybbit.name" . }}
        {{- $postgresqlName := include "rybbit.postgresql.name" . }}
        {{- printf "%s-%s" $name $postgresqlName | trunc 63 | trimSuffix "-" }}
    {{- end }}
{{- end }}

{{/*
Create a default fully qualified pvc name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "rybbit.postgresql.pvcName" -}}
    {{- $name := include "rybbit.postgresql.fullname" . }}
    {{- printf "%s-%s" $name "data" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "rybbit.postgresql.labels" -}}
helm.sh/chart: {{ include "rybbit.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{ include "rybbit.postgresql.selectorLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "rybbit.postgresql.selectorLabels" -}}
app.kubernetes.io/name: {{ include "rybbit.postgresql.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
