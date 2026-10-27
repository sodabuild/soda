// The MPC signing committee was shut down on 28 Oct 2026. Its Railway
// services (two nodes, coordinator, subscriber, relayer) no longer run, so
// any request that needs a committee signature cannot finish.
//
// The pages keep their explanation and address derivation, but the signing
// controls show a notice instead. The API routes that sign or spend the
// funder wallet answer 410, so nobody can drain the sponsor through them.
//
// To bring the demo back, redeploy the services and set this to false.

import type { NextApiResponse } from "next";

export const MPC_RETIRED = true;

export const MPC_RETIRED_MESSAGE =
  "The MPC demo is retired. Its signing committee no longer runs.";

export function rejectRetired(res: NextApiResponse): void {
  res.status(410).json({ error: MPC_RETIRED_MESSAGE });
}
