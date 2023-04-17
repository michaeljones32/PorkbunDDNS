# PorkbunDDNS
Simple dockerised bash script to update Porkbun DNS entries

##
Simple Docker run:
```
docker run --name porkbunddns \
 -e DOMAINS_TO_UPDATE=sub.domain.com,sub2.domain.com \
 -e PORKBUN_API=pk1_apiKey \
 -e PORKBUN_SECRET=sk1_secretKey \
 -e SLEEP_TIME=300 \
 ghcr.io/michaeljones32/porkbundns:latest
 ```