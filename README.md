# statiserve

Serve static websites with docker, nginx and IPFS in a single container.

IPFS implements a gateway to serve content out of the box, but with this container:

- Instead of serving arbitrary data, you can specify a hash and it will be served on the root path.

- NGINX is optimized with a local cache and high compression to serve static websites.

- Builds ready in Dockerhub for both AMD64 and ARM64

## Usage

Use the `IPFS_HASH` environment variable to specify the IPFS or IPNS hash to serve.
For example:

```
IPFS_HASH=/ipfs/QmbRtS9dp2zqARv7v7ak2reJp3zE5NRkvEpHsc48Hjo9MF/
```
