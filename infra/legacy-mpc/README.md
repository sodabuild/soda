# Legacy MPC hosting files

These files run the MPC signer (two `mpc-node` instances and the
`mpc-coordinator`) outside Railway. The MPC signer was retired on 28 Oct 2026, and its Railway
services no longer run. These files stay as the reference for running it
again.

| File | What it does | Status |
|---|---|---|
| `docker-compose.mpc.yml` | Runs p1, p2, and the coordinator locally. Used by `pnpm mpc:up` and `pnpm mpc:down`. | Works from the repo root through the pnpm scripts |
| `Dockerfile.mpc-aio` | One image that runs p1, p2, and the coordinator together, supervised by `scripts/mpc-all-in-one.mjs`. Build from the repo root: `docker build -f infra/legacy-mpc/Dockerfile.mpc-aio .` | Not used by any current deployment |
| `render.yaml` | Render Blueprint for the old Render deployment, which was deleted. Render reads a Blueprint only from the repository root, so move it back before reusing it. | Not used |

Railway did not use these files. Its services built from `apps/*/Dockerfile`.
