from fastapi import HTTPException, Security

from fastapi.security import APIKeyHeader
from starlette.status import HTTP_401_UNAUTHORIZED

API_KEY_NAME = "token"
api_key_header = APIKeyHeader(name=API_KEY_NAME, auto_error=False)


def get_api_key(api_key: str = Security(api_key_header)):
    if api_key == "local":
        return api_key
    else:
        raise HTTPException(
            status_code=HTTP_401_UNAUTHORIZED,
            detail="Access Denied",
        )
