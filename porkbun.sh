#!/bin/bash
sleep_time=$(printenv SLEEP_TIME)

[  -z "$sleep_time" ] && echo "Setting sleep time to default 5 minutes"; sleep_time=300 || echo $sleep_time

while true
do
    #grab WAN IP from canhazip
    output=$(curl -s http://canhazip.com)

    domains=$(printenv DOMAINS_TO_UPDATE)
    IFS=', ' read -r -a domains_to_update <<< "$domains"
    for domain in "${domains_to_update[@]}" 
    do
        currentAddress=$(nslookup $domain 1.1.1.1 | awk '/^Address: / { print $2 }')
        if [[ "$output" != "$currentAddress" ]]; then
            echo "Setting IP for $domain to $output..."
            apiKey=$(printenv PORKBUN_API)
            secretKey=$(printenv PORKBUN_SECRET)
            subdomain=$(echo $domain | cut -d "." -f 1)
            mainDomain=$(echo $domain | cut -d "." -f 2-)
            curl \
                --header "Content-type: application/json" \
                --request POST \
                --data '{"secretapikey":"'$secretKey'","apikey":"'$apiKey'","content":"'$output'"}' \
                https://porkbun.com/api/json/v3/dns/editByNameType/$mainDomain/A/$subdomain
        else
            echo "$domain already has the correct IP ($output), skipping..."
        fi
    done
    sleep $sleep_time 
done