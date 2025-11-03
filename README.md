# MikroTik IKEv2 VPN (Certificados RSA) – FlowitAR Configuration

Configuración completa de un servidor VPN IKEv2 en MikroTik RouterOS 7.20+, utilizando autenticación por certificados RSA.  
Compatible con Windows, macOS, Android (StrongSwan) e iOS.

---

## Instalación rápida

1. Subir el archivo `mikrotik-ikev2.rsc` al router.
2. Ejecutarlo con:
/import file-name=mikrotik-ikev2.rsc

markdown
Copiar código
3. Exportar los certificados con:
/certificate export-certificate FlowitAR-CA export-passphrase=""
/certificate export-certificate Client-Facu export-passphrase="1234"

yaml
Copiar código
4. Descargar los archivos `.crt` y `.p12` desde el menú **Files**.

---

## Red y direcciones

| Elemento | Valor |
|-----------|-------|
| IP Pool VPN | 192.168.200.10–192.168.200.50 |
| DNS clientes | 8.8.8.8 |
| Modo | IKEv2 con certificados RSA |
| Certificados | FlowitAR-CA, FlowitAR-Server, Client-Facu |

---

## Archivos generados

- `FlowitAR-CA.crt` (CA raíz, instalar en cliente)
- `Client-Facu.p12` (certificado de cliente)

---

## Créditos

Autor: **Facundo Camacho (FlowitAR)**  
Repositorio: [https://github.com/Sheyrion1](https://github.com/Sheyrion1)  
Licencia: MIT
