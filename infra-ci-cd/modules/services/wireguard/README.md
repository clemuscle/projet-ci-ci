### Conf client
```
[Interface]
PrivateKey = +NS8e/EtDaEcDpvMtDmU6icMzQTLbK13UhV3aMMcf34=
Address = 10.0.1.2/24
DNS = 1.1.1.1

[Peer]
PublicKey = <public_key_instance>
AllowedIPs = 0.0.0.0/0
Endpoint = <adresse_ip_instance>:51820
```

Need to add to the server like this:
sudo wg set wg0 peer <public_key_client> allowed-ips 10.0.1.2

Needs to find a way to output the public key of wireguard for people to add it to their conf.
But also to add clients to the server.