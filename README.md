# keycloak_26-app

Immagine Keycloak ottimizzata per il cluster Kubernetes locale CCNO.

## Versione

- Keycloak server: `26.8.1`
- Keycloak Operator: `26.8.1`, dichiarato nel repository `idm-gitops`
- database runtime: PostgreSQL

Server e Operator devono essere aggiornati insieme dopo aver verificato le note di
migrazione e il backup del database.

## Contenuto del repository

- `Dockerfile`: crea l'immagine ottimizzata partendo dall'immagine ufficiale;
- `providers/`: eventuali estensioni SPI Keycloak;
- `themes/`: eventuali temi personalizzati;
- `.github/workflows/`: validazione, pubblicazione e promozioni GitOps.

La distribuzione binaria Keycloak e i dump dei database non sono versionati. Le
configurazioni runtime e i Secret appartengono a Kubernetes e al repository GitOps.

## Build locale

```bash
docker build --build-arg KEYCLOAK_VERSION=26.8.1 -t keycloak-26-app:local .
docker run --rm keycloak-26-app:local --version
```

## Flusso di rilascio

- pull request verso `main`: costruzione e verifica dell'immagine, nessun deploy;
- push su `main`: pubblicazione dell'immagine immutabile e deploy in `local-test`;
- tag `vMAJOR.MINOR.PATCH`: promozione della stessa immagine in `local-qual`;
- avvio manuale del workflow prod: promozione della stessa immagine in `local-prod`.

L'immagine pubblicata usa il nome:

```text
localhost:5001/keycloak-26-app:<git-sha>
```

