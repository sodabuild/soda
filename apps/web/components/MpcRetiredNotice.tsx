import Link from "next/link";

// Shown where the MPC demo's sign buttons used to be. See lib/mpc-retired.ts.
export default function MpcRetiredNotice() {
  return (
    <div className="rounded-lg border border-zinc-700 bg-zinc-900 px-4 py-3 text-sm text-zinc-300">
      <div className="font-medium text-zinc-100">MPC demo retired</div>
      <p className="mt-1 text-zinc-400">
        The MPC signing committee no longer runs, so this page cannot sign.
        SODA now proves Solana approvals with Alpenglow certificates instead.{" "}
        <Link href="/alpenglow" className="text-zinc-100 underline">
          See the Alpenglow demo
        </Link>
        .
      </p>
    </div>
  );
}
