#!/data/data/com.termux/files/usr/bin/bash
cd ~/bit-gold-omega
pkill -f omega_p2p.py; pkill -f l2_p2p.py; pkill -f mine-auto.py; pkill -f l2_mine.py; pkill -f "ssh -R 80:"
sleep 1
nohup python3 omega_p2p.py > omega_p2p.log 2>&1 &
nohup python3 l2_p2p.py > l2_p2p.log 2>&1 &
nohup python3 mine-auto.py > mine.log 2>&1 &
nohup python3 l2_mine.py > l2_mine.log 2>&1 &
nohup python3 -m http.server 8081 --bind 0.0.0.0 > explorer.log 2>&1 &
nohup ssh -R 80:127.0.0.1:8333 nokey@localhost.run > tunnel.log 2>&1 &
nohup ssh -R 80:127.0.0.1:8334 nokey@localhost.run > l2_tunnel.log 2>&1 &
sleep 7
echo "L1 $(grep -o https://.*lhr.life tunnel.log | tail -1) $(curl -s http://127.0.0.1:8333/ | python -m json.tool | grep height)"
echo "L2 $(grep -o https://.*lhr.life l2_tunnel.log | tail -1) $(curl -s http://127.0.0.1:8334/ | python -m json.tool | grep l2_height)"
