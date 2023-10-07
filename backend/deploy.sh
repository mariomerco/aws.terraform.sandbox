aws cloudformation deploy \
    --stack-name terraform-backend \
    --template-file backend.yaml


# Resource handler returned message: "Service returned error code MalformedPolicyDocumentException (Service: Kms, Status Code: 400, Request ID: 45033ea2-3ed5-4b48-b542-017cdf938df5)" (RequestToken: 357e0c7e-819f-c8ac-e01a-e941382fc14c, HandlerErrorCode: InvalidRequest)