# helm-eks-action
Github Action for  executing Helm commands on EKS (using aws-iam-authenticator).

The Helm version installed is Helm3.

This action was inspired by [kubernetes-action](https://github.com/Jberlinsky/kubernetes-action).

# Instructions

This Github Action was created with EKS in mind, therefore the following example refers to it.

## Input variables

1. `plugins`: you can specify a list of Helm plugins you'd like to install and use later on in your command. eg. helm-secrets or helm-diff. This action does not support only a specific list of Helm plugins, rather any Helm plugin as long as you supply its URL. You can use the following [example](#example) as a reference.
2. `command`: your kubectl/helm command. This supports multiline as per the Github Actions workflow syntax.

example for multiline:
```yaml
...
with:
  command: |
    helm upgrade --install my-release chart/repo
    kubectl get pods
```

## Example

```yaml
name: deploy

on:
    push:
        branches:
            - master
            - develop

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2

      - name: AWS Credentials
        uses: aws-actions/configure-aws-credentials@v1
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: us-east-1

      - name: helm deploy
        uses: skiyl9x/ansible-aws-action@main
        with:
          command: ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook playbook.yml -i inventory.yaml --extra-vars='ansible_become_pass=user proxy_pass=pass proxy_user=user ansible_ssh_private_key_file=path/to/private_key ansible_user=user'
```

# Response

Use the output of your command in later steps

```yaml
    steps:
      - name: Get URL
        id: url
        uses: koslib/helm-eks-action@master
        env:
          KUBE_CONFIG_DATA: ${{ secrets.KUBE_CONFIG_DATA }}
        with:
          command: kubectl get svc my_svc -o json | jq -r '.status.loadBalancer.ingress[0].hostname'

      - name: Print Response
        run: echo "Response was ${{ steps.url.outputs.response }}"

```


