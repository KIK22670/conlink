## Synchronisieren des Repositorys in einen Ordner

Installiere die neueste Version von [git](https://git-scm.com/downloads) mit den Standardeinstellungen.
Öffne dann ein Terminal, navigiere zu einem geeigneten Ordner und führe folgenden Befehl aus:

```
git clone https://github.com/KIK22670/conlink
```
1. Projekt runterladen
  CMD öfnnen und das ausführen git clone https://github.com/KIK22670/conlink
2. Docker runterladen
3. Postgres oder DBeaver runterladen
4. IN Visual Studio Code das Projekt öffnen und ein Terminal Fenster öffnen.
     --> man gibt in Terminal dann "npm i"
5. DOcker  starten und diesen Befehl auch in CMD ausführen: docker run -d -p 5432:5432 --name some-postgres -e POSTGRES_PASSWORD=rootUser postgres 
6. Dbeaver oder Pgadmin starten eine neue verbindung anlegen mit postgres und dann die Daten von connection.js da reingeben und das sql script ausführen, was SCHEMA.sql heißt;
7. wieder in visual Studio code node app.js und dann sollte es laufen
