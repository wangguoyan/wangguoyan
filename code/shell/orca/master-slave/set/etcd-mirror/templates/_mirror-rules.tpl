{{/*
Rules for etcd mirror
*/}}
{{- define "etcd.mirror.rules" }}
apiVersion: v1
kind: ConfigMap
metadata:
  labels:
    control-plane: orca-etcd-mirror
  name: {{ .Values.configmap.mirror_rules.name }}
  namespace: {{ .Release.Namespace }}
data:
  rules.yaml: |
    filters:
      sequential:
      - group: apiextensions.k8s.io
        sequence: 1
        resources:
          - group: apiextensions.k8s.io
            version: {{ include "capabilities.crd.version" . }}
            kind: CustomResourceDefinition
      - group: core.orcastack.io
        sequence: 2
        resources:
          - group: core.orcastack.io
            version: v1
            kind: Tenant
      - group: ""
        sequence: 3
        resources:
          - version: v1
            kind: Namespace
        labelSelectors:
          - matchExpressions:
              - key: orcastack.io/namespace-kind
                operator: In
                values:
                  - tenant
                  - rss
      secondary:
      - group: "*.orcastack.io"
        namespaceSelectors:
          - matchExpressions:
              - key: orcastack.io/namespace-kind
                operator: In
                values:
                  - tenant
                  - rss
        excludes:
          - resource:
              group: "app.orcastack.io"
              version: v1beta1
              kind: OrcaCell
            labelSelectors:
              - matchExpressions:
                  - key: app.orcastack.io/required-on-controller
                    operator: In
                    values:
                      - "true"
      - group: "monitoring.coreos.com"
        resources:
          - group: monitoring.coreos.com
            version: v1alpha1
            kind: AlertmanagerConfig
          - group: monitoring.coreos.com
            version: v1
            kind: PrometheusRule
          - group: monitoring.coreos.com
            version: v1
            kind: ServiceMonitor
          - group: monitoring.coreos.com
            version: v1
            kind: PodMonitor
        namespaceSelectors:
          - matchExpressions:
              - key: orcastack.io/namespace-kind
                operator: In
                values:
                  - tenant
                  - rss
      - group: ""
        resources:
          - version: v1
            kind: ConfigMap
        namespaceSelectors:
          - matchExpressions:
              - key: orcastack.io/namespace-kind
                operator: In
                values:
                  - tenant
                  - rss
      - group: ""
        resources:
          - version: v1
            Kind: Secret
        namespaceSelectors:
          - matchExpressions:
              - key: orcastack.io/namespace-kind
                operator: In
                values:
                  - tenant
                  - rss
        fieldSelectors:
          - matchExpressions:
              - key: type
                operator: NotIn
                values:
                  - kubernetes.io/service-account-token
      - group: "*.orcastack.io"
        namespace: orca-system
        excludes:
          - resource:
              group: core.orcastack.io
              version: v1alpha1
              kind: Cluster
            labelSelectors:
              - matchExpressions:
                  - key: orcastack.io/role
                    operator: In
                    values:
                      - "controller"
          - resource:
              group: core.orcastack.io
              version: v1alpha1
              kind: ClusterCredential
            labelSelectors:
              - matchExpressions:
                  - key: orcastack.io/controller-cluster
                    operator: In
                    values:
                      - "true"
          - resource:
              group: failover.orcastack.io
              version: v1alpha1
              kind: ControllerFailOver
          - resource:
              group: failover.orcastack.io
              version: v1alpha1
              kind: ClusterFailOver
      - group: ""
        resources:
          - version: v1
            kind: ConfigMap
          - version: v1
            Kind: Secret
        namespace: orca-system
        labelSelectors:
          - matchExpressions:
              - key: orcastack.io/configuration
                operator: Exists
          - matchExpressions:
              - key: orcastack.io/credential
                operator: Exists
          - matchExpressions:
              - key: repo.orcastack.io/docker-registry
                operator: Exists
        excludes:
          - resource:
              version: v1
              kind: Secret
            name: orca-password-secret
            namespace: orca-system
      - group: "*"
        namespace: orca-public
        excludes:
          - resource:
              version: v1
              kind: ConfigMap
            name: password-rsa-key
            namespace: orca-public
      - group: ""
        resources:
        - version: v1
          Kind: Secret
        namespace: orca-components
        labelSelectors:
        - matchExpressions:
            - key: orcastack.io/credential-for
              operator: Exists
      - group: "*.orcastack.io"
        namespace: orca-components
        excludes:
          - resource:
              group: "app.orcastack.io"
              version: v1beta1
              kind: OrcaCell
            labelSelectors:
              - matchExpressions:
                  - key: app.orcastack.io/required-on-controller
                    operator: In
                    values:
                      - "true"
{{- end -}}
