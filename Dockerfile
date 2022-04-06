FROM alpine:3.13

RUN apk add py-pip curl ca-certificates bash ansible\
    && pip install 'awscli==1.22.26' boto3 \
    && curl -o /usr/bin/aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/aws-iam-authenticator \
    && chmod +x /usr/bin/aws-iam-authenticator

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]:
