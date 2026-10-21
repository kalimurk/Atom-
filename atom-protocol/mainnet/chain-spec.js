export const ATOM_MAINNET = {
  chainId: 42069,
  chainName: "ATOM Mainnet",
  rpc: "https://rpc.atom-chain.yourdomain.com",
  explorer: "https://explorer.atom-chain.yourdomain.com",
  nativeCurrency: { name: "ATOM", symbol: "ATOM", decimals: 18 },
  blockTime: 2,
  maxSupply: 21000000n * 10n**18n,
  consensus: "isolated-pow-sha256d",
  finality: "single-node-validated-410-blocks"
}
console.log("ATOM Mainnet spec:", ATOM_MAINNET);
