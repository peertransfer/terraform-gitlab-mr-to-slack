---
labels:
%{ for label, slack_channel in labels_to_notify ~}
  "${label}": "${slack_channel}"
%{ endfor ~}
