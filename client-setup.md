CERTIFICADOS IKEv2 – FACUNDO CAMACHO

1. Crear CA (facundo-camacho-CA)
   /certificate add name=ca-facundo-camacho common-name=facundo-camacho-CA key-usage=key-cert-sign,crl-sign
   /certificate sign ca-facundo-camacho name=facundo-camacho-CA

2. Crear certificado del servidor
   /certificate add name=server-facundo-camacho common-name=facundo-camacho-server key-usage=digital-signature,key-encipherment,tls-server
   /certificate sign server-facundo-camacho ca=facundo-camacho-CA name=facundo-camacho-Server

3. Crear certificado del cliente
   /certificate add name=client-facundo-camacho common-name=facundo-camacho key-usage=digital-signature,tls-client
   /certificate sign client-facundo-camacho ca=facundo-camacho-CA name=facundo-camacho-Client

4. Exportar certificados
   /certificate export-certificate facundo-camacho-CA export-passphrase=""
   /certificate export-certificate facundo-camacho-Client export-passphrase="1234"

Archivos exportados:
- facundo-camacho-CA.crt     (Certificado raíz, instalar en el cliente)
- facundo-camacho-Client.p12 (Certificado del cliente con clave privada)
