{{- define "rybbit.backend.name" -}}
{{- default "backend" .Values.backend.nameOverride }}
{{- end}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "rybbit.backend.fullname" -}}
    {{- if .Values.backend.fullnameOverride }}
        {{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
        {{- else }}
        {{- $name := include "rybbit.name" . }}
        {{- $backendName := include "rybbit.backend.name" . }}
        {{- printf "%s-%s" $name $backendName | trunc 63 | trimSuffix "-" }}
    {{- end }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "rybbit.backend.labels" -}}
helm.sh/chart: {{ include "rybbit.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{ include "rybbit.backend.selectorLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "rybbit.backend.selectorLabels" -}}
app.kubernetes.io/name: {{ include "rybbit.backend.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
