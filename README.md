# asn-ip-prefix-full-list
Full list of IP prefixes belonging to every ASN (16 and 32 bit) that is currently used

## Why?

Mainly for network monitoring. I needed a list of ASN-prefix pairs to use with [pmacct](https://github.com/pmacct/pmacct) (see `networks_file` in [config](https://github.com/pmacct/pmacct/blob/master/CONFIG-KEYS)) and [AS-Stats](https://github.com/manuelkasper/AS-Stats).

## How?

I've got the currently assigned ASNs from [IANA AS number assignment list](https://www.iana.org/assignments/as-numbers/as-numbers.xhtml) and queried whois.radb.net for related IPv4 and IPv6 prefixes for every one of them.

This is a quite long process so a small bit of parralelism is included as well. (I had errors when I went above 4 threads, maybe because of RADb limitation?) Anyway, the script took a few hours to finish.
