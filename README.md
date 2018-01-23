# SSL Cert Test Stack

Docker images of a simple nginx server and a client to allow full verification of an ssl certificate to a root ca certificate.


## Setup

- For the server, add:
    -  the ssl certificate as `server/config/ssl/cert.pem`
    -  the ssl certificate's key as `server/config/ssl/cert.key.pem`

- For the client, add:
    - the root ca certificate to `client/config/ssl/`

- In an editor, open the `docker-compose.yml` file, then 'find and replace' the string `REPLACE-ME-WITH-FQDN` with the ssl certificate's `fully.qualified.domain.name`, e.g. replace `REPLACE-ME-WITH-FQDN` with `www.amazon.com` (if you happen to be testing the Amazon ssl certificate!)

**Note**: If changes are made to the certificate files on either the client or the server, simply teardown the stack and relaunch (see instruction below).


## Launch, Test, Teardown

The following examples show testing an ssl certificate for the domain `pki.my-test-domain.com`

- **Launch**

    ```sh
    $ docker-compose up [--build]

    # then, watch the logs
    ```

    The `--build` switch is of course optional, should you need to rebuild the docker images at any point in the future.

- **Test**

    In another shell...

    ```sh
    $ docker exec ssl-cert-test-client curl -v https://pki.my-test-domain.com/
    *   Trying 172.18.0.2...
    * TCP_NODELAY set
    * Connected to pki.my-test-domain.com (172.18.0.2) port 443
    * ALPN, offering http/1.1
    * successfully set certificate verify locations:
    *   CAfile: /etc/ssl/certs/ca-certificates.crt
      CApath: none
    * TLSv1.2 (OUT), TLS handshake, Client hello (1):
    * TLSv1.2 (IN), TLS handshake, Server hello (2):
    * TLSv1.2 (IN), TLS handshake, Certificate (11):
    * TLSv1.2 (IN), TLS handshake, Server key exchange (12):
    * TLSv1.2 (IN), TLS handshake, Server finished (14):
    * TLSv1.2 (OUT), TLS handshake, Client key exchange (16):
    * TLSv1.2 (OUT), TLS change cipher, Client hello (1):
    * TLSv1.2 (OUT), TLS handshake, Finished (20):
    * TLSv1.2 (IN), TLS change cipher, Client hello (1):
    * TLSv1.2 (IN), TLS handshake, Finished (20):
    * SSL connection using TLSv1.2 / ECDHE-RSA-AES256-GCM-SHA384
    * ALPN, server accepted to use http/1.1
    * Server certificate:
    *  subject: C=UK; ST=Greater London; L=London; O=Test; OU=Test Dept; CN=pki.my-test-domain.com; emailAddress=security@my-test-domain.com
    *  start date: Jan 23 15:09:17 2018 GMT
    *  expire date: Jan 23 15:09:17 2019 GMT
    *  common name: pki.my-test-domain.com (matched)
    *  issuer: C=UK; ST=Greater London; L=London; O=Test; OU=Test Dept; CN=*.my-test-domain.com; emailAddress=security@my-test-domain.com
    *  SSL certificate verify ok.
    > GET / HTTP/1.1
    > Host: pki.my-test-domain.com
    > User-Agent: curl/7.57.0
    > Accept: */*
    >
    < HTTP/1.1 200 OK
    < Server: nginx/1.13.8
    < Date: Tue, 23 Jan 2018 18:59:01 GMT
    < Content-Type: text/html
    < Content-Length: 403
    < Last-Modified: Tue, 23 Jan 2018 14:27:29 GMT
    < Connection: keep-alive
    < ETag: "5a674651-193"
    < Accept-Ranges: bytes
    <
    <!DOCTYPE html>
    <html>
    <head>
      <title>ssl cert test stack</title>
    </head>
    <body>
      <h1>Hello!</h1>
      <p>This is my simple index page</p>
    </body>
    </html>
    * Connection #0 to host pki.my-test-domain.com left intact
    ```

    Alternatively, to debug or test from the client box...

    ```sh
    # jump on the client box
    $ docker exec -it ssl-cert-test-client bash

    # then issue commands from there, e.g.
    $ curl -v https://pki.my-test-domain.com/

    # or even
    $ ping pki.my-test-domain.com
    ```

- **Teardown**

    ```sh
    # if on the client box, first...
    bash-4.4# exit

    $ docker-compose down
    ```
