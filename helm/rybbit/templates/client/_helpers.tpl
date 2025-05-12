{{- define "rybbit.client.name" -}}
{{- default "client" .Values.client.nameOverride }}
{{- end}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "rybbit.client.fullname" -}}
    {{- if .Values.client.fullnameOverride }}
        {{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
        {{- else }}
        {{- $name := include "rybbit.name" . }}
        {{- $clientName := include "rybbit.client.name" . }}
        {{- printf "%s-%s" $name $clientName | trunc 63 | trimSuffix "-" }}
    {{- end }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "rybbit.client.labels" -}}
helm.sh/chart: {{ include "rybbit.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{ include "rybbit.client.selectorLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "rybbit.client.selectorLabels" -}}
app.kubernetes.io/name: {{ include "rybbit.client.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
