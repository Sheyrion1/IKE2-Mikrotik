# ============================================================
# MikroTik IKEv2 VPN (RSA Certificates)
# Autor: Facundo Camacho (FlowitAR)
# RouterOS: 7.20+
# Hardware probado: hEX S
# ============================================================

# --- Crear CA (Autoridad Certificadora) ---
/certificate
add name=ca-flowit common-name=FlowitAR-CA key-usage=key-cert-sign,crl-sign
sign ca-flowit name=FlowitAR-CA

# --- Crear certificado del servidor ---
add name=server-flowitAR common-name=flowitar-server key-usage=digital-signature,key-encipherment,tls-server
sign server-flowitAR ca=FlowitAR-CA name=FlowitAR-Server

# --- Crear certificado del cliente ---
add name=client-facu common-name=Facu key-usage=digital-signature,tls-client
sign client-facu ca=FlowitAR-CA name=Client-Facu

# --- Marcar certificados como confiables ---
/certificate set FlowitAR-CA trusted=yes
/certificate set FlowitAR-Server trusted=yes

# --- Crear IP pool para clientes VPN ---
/ip pool add name=ike2-pool ranges=192.168.200.10-192.168.200.50

# --- Crear configuración de modo (ModeConfig) ---
/ip ipsec mode-config add \
    name=ike2-conf \
    address-pool=ike2-pool \
    address-prefix-length=32 \
    split-include=0.0.0.0/0 \
    static-dns=8.8.8.8 \
    system-dns=no

# --- Crear perfil, propuesta y peer ---
/ip ipsec profile add name=ike2-profile enc-algorithm=aes-256 hash-algorithm=sha256 dh-group=modp2048
/ip ipsec proposal add name=ike2-proposal auth-algorithms=sha256 enc-algorithms=aes-256-cbc,aes-256-gcm pfs-group=none
/ip ipsec peer add name=ike2-peer exchange-mode=ike2 profile=ike2-profile passive=yes

# --- Crear identidad (RSA Sign) ---
/ip ipsec identity add \
    auth-method=rsa-signature \
    certificate=FlowitAR-Server \
    remote-certificate=Client-Facu \
    mode-config=ike2-conf \
    peer=ike2-peer \
    generate-policy=port-strict

# --- NAT para salida a Internet desde la VPN ---
/ip firewall nat add chain=srcnat src-address=192.168.200.0/24 action=masquerade

# --- Activar IPsec ---
/ip ipsec settings set enabled=yes

# --- Fin del script ---
# Verificar con:
/ip ipsec active-peers print
/log print where message~"ipsec"
