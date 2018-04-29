KEY="PUT_FINGERPRINT_HERE";
ssh-keyscan -t rsa PUT_URL_OR_IP_HERE > key.tmp;
KEY_CMP=$(ssh-keygen -lf key.tmp | cut -f 2 -d ' ');
if [ "$KEY" = "$KEY_CMP" ]; then
    mkdir -p "${HOME}/.ssh";
    cat key.tmp >> "${HOME}/.ssh/known_hosts";
fi;
ssh-keygen -H -f "${HOME}/.ssh/known_hosts";
