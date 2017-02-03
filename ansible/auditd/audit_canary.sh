#!/bin/bash
echo '#!/bin/true' > /var/tmp/canary && chmod +x /var/tmp/canary && /var/tmp/canary && rm -f /var/tmp/canary
