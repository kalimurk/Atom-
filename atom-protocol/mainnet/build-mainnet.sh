#!/data/data/com.termux/files/usr/bin/bash
echo "Building ATOM Mainnet 42069 from 410 blocks..."
cp chain-data/atom-testnet.log mainnet/genesis-history-410.log
wc -l mainnet/genesis-history-410.log
cat > mainnet/docker-compose.mainnet.yml <<'YAML'
version: '3.8'
services:
  atom-sequencer:
    image: node:20
    working_dir: /app
    volumes: [.:/app]
    command: node computation/node-persist.js
    ports: ["8545:8545","3000:3000"]
  atom-explorer:
    image: node:20
    working_dir: /app
    volumes: [.:/app]
    command: node computation/api.js
    ports: ["3000:3000"]
YAML
cat > mainnet/mainnet-node.js <<'JS'
import fs from 'fs';
const chainId = 42069;
const blocks = fs.readFileSync('./mainnet/genesis-history-410.log','utf8').trim().split('\n');
const genesis = blocks[0];
const latest = blocks[blocks.length-1];
console.log(`ATOM Mainnet ${chainId} GENESIS READY`);
console.log(`Genesis: ${genesis.slice(0,80)}...`);
console.log(`Latest #${blocks.length}: ${latest.slice(0,80)}...`);
console.log(`History: ${blocks.length} blocks exported as mainnet genesis`);
console.log(`RPC: https://rpc.atom-chain.yourdomain.com -> :8545`);
console.log(`Explorer: https://explorer.atom-chain.yourdomain.com -> :3000`);
JS
node mainnet/mainnet-node.js
