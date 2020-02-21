# Sesame Postfix Docker

Here is a sample `.env` file.

`` bash
# Main mail domain
DOMAIN=sample.com

# Hostnames for this server, separated with comas
HOSTNAME=sample.com

# Size limit in bytes
HEADER_SIZE_LIMIT=51200
MESSAGE_SIZE_LIMIT=50000000

# Networks granted relay permissions
# Use this with care, all hosts in this networks will be able to send mail without authentication!
RELAYNETS=

# Will relay all outgoing mails if configured
RELAYHOST=

SUBNET=

# Recipient delimiter, character used to delimiter localpart from custom address part
RECIPIENT_DELIMITER=+

DELIVERY_USER=poster
DELIVERY_PASSWORD=poster
```