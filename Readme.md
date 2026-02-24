Ecco la consegna completa con TUTTI i comandi, inclusi quelli della treasure hunt!

# 🐧 Esercitazione Completa: Comandi Linux

## Obiettivo
Crea la struttura di cartelle e file richiesta nella tua home directory, usando tutti i comandi fondamentali di Linux.

**Cartella di lavoro:** `~/lab_linux`

Per iniziare:
```bash
cd ~
mkdir lab_linux
cd lab_linux
```
---

## PARTE 1: Navigazione e Creazione Directory (cd, pwd, mkdir)

### Comandi da conoscere:
- `cd <percorso>` → Cambia directory
- `cd ..` → Vai alla directory padre
- `cd ~` → Vai alla home
- `pwd` → Mostra il percorso corrente
- `mkdir <nome>` → Crea una directory
- `mkdir -p a/b/c` → Crea directory annidate

### 🎯 DA FARE:

Crea questa struttura (circa **15 utilizzi** di mkdir):
```

lab_linux/
├── documenti/
│   ├── lavoro/
│   │   ├── report/
│   │   └── presentazioni/
│   ├── personale/
│   └── archivio/
│       ├── 2023/
│       └── 2024/
├── progetti/
│   ├── webapp/
│   │   ├── src/
│   │   ├── docs/
│   │   └── test/
│   ├── script/
│   └── backup_progetti/
├── sistema/
│   ├── config/
│   ├── logs/
│   └── temp/
├── multimedia/
│   ├── immagini/
│   ├── video/
│   └── audio/
└── download/
├── completi/
└── in_corso/
```
---

## PARTE 2: Creazione File Vuoti (touch)

### Comandi da conoscere:
- `touch <file>` → Crea un file vuoto (o aggiorna la data di modifica)
- `touch file1 file2 file3` → Crea più file insieme

### 🎯 DA FARE (10+ utilizzi):

1. `documenti/lavoro/report/report_q1.txt`
2. `documenti/lavoro/report/report_q2.txt`
3. `documenti/lavoro/report/report_q3.txt`
4. `documenti/lavoro/report/report_q4.txt`
5. `documenti/lavoro/presentazioni/slide_intro.pptx`
6. `documenti/personale/note.txt`
7. `progetti/webapp/src/index.html`
8. `progetti/webapp/src/style.css`
9. `progetti/webapp/src/app.js`
10. `progetti/webapp/docs/README.md`
11. `progetti/script/backup.sh`
12. `progetti/script/cleanup.sh`
13. `sistema/logs/sistema.log`
14. `sistema/logs/errori.log`
15. `sistema/config/settings.conf`

---

## PARTE 3: Scrittura File con Nano (nano)

### Comandi da conoscere:
- `nano <file>` → Apre l'editor di testo
- `CTRL+O` → Salva
- `CTRL+X` → Esci
- `CTRL+K` → Taglia riga
- `CTRL+U` → Incolla riga

### 🎯 DA FARE (10 file da editare):

**1. `documenti/lavoro/report/report_q1.txt`:**
```

Report Primo Trimestre 2024
===========================
Vendite totali: 45000 euro
Obiettivo: 40000 euro
Stato: SUPERATO
```
**2. `documenti/lavoro/report/report_q2.txt`:**
```

Report Secondo Trimestre 2024
=============================
Vendite totali: 52000 euro
Obiettivo: 45000 euro
Stato: SUPERATO
```
**3. `documenti/personale/note.txt`:**
```

Note personali
--------------
- Imparare Linux
- Praticare i comandi ogni giorno
- Non aver paura del terminale!
```
**4. `progetti/webapp/src/index.html`:**
```
html
<!DOCTYPE html>
<html>
<head>
    <title>La mia webapp</title>
</head>
<body>
    <h1>Benvenuto!</h1>
</body>
</html>
```
**5. `progetti/webapp/src/style.css`:**
```
css
body {
    font-family: Arial, sans-serif;
    background-color: #f0f0f0;
}
h1 {
    color: #333;
}
```
**6. `progetti/webapp/src/app.js`:**
```
javascript
console.log("Applicazione avviata!");
function saluta(nome) {
    return "Ciao, " + nome + "!";
}
```
**7. `progetti/webapp/docs/README.md`:**
```
markdown
# WebApp Project
Versione: 1.0.0
Autore: [Il tuo nome]
Descrizione: Una semplice webapp di esempio.
```
**8. `progetti/script/backup.sh`:**
```
bash
#!/bin/bash
echo "Avvio backup..."
cp -r ~/lab_linux/progetti ~/lab_linux/sistema/temp/
echo "Backup completato!"
```
**9. `progetti/script/cleanup.sh`:**
```
bash
#!/bin/bash
echo "Pulizia file temporanei..."
rm -rf ~/lab_linux/sistema/temp/*
echo "Pulizia completata!"
```
**10. `sistema/config/settings.conf`:**
```

# Configurazione Sistema
debug_mode=false
log_level=INFO
max_connections=100
timeout=30
```
---

## PARTE 4: Visualizzazione File (cat, ls)

### Comandi da conoscere:
- `cat <file>` → Mostra il contenuto di un file
- `cat file1 file2` → Concatena e mostra più file
- `cat *.txt` → Mostra tutti i .txt
- `ls` → Lista file
- `ls -l` → Lista dettagliata
- `ls -la` → Include file nascosti
- `ls -lh` → Dimensioni leggibili

### 🎯 DA FARE (10+ utilizzi):

1. Visualizza `report_q1.txt`
2. Concatena e visualizza TUTTI i report insieme: `cat report_q*.txt`
3. Visualizza `settings.conf`
4. Lista i file in `progetti/webapp/src/`
5. Lista dettagliata di `documenti/lavoro/`
6. Concatena `index.html`, `style.css` e `app.js`
7. Visualizza `README.md`
8. Lista tutti i file `.sh` in `progetti/script/`
9. Lista ricorsiva di `progetti/` con `ls -R`
10. Visualizza tutti i `.log` in `sistema/logs/`

---

## PARTE 5: Copia File e Directory (cp)

### Comandi da conoscere:
- `cp <sorgente> <destinazione>` → Copia un file
- `cp -r <dir> <dest>` → Copia una directory (ricorsivo)
- `cp file1 file2 dir/` → Copia più file in una directory

### 🎯 DA FARE (12 copie):

1. Copia `report_q1.txt` in `archivio/2024/`
2. Copia `report_q2.txt` in `archivio/2024/`
3. Copia `report_q3.txt` in `archivio/2024/`
4. Copia `report_q4.txt` in `archivio/2024/`
5. Copia TUTTA la cartella `webapp` in `backup_progetti/` (usa `cp -r`)
6. Copia `backup.sh` in `sistema/`
7. Copia `cleanup.sh` in `sistema/`
8. Copia `settings.conf` in `progetti/webapp/`
9. Copia `README.md` in `documenti/lavoro/`
10. Copia `note.txt` in `archivio/2024/`
11. Copia tutti i file `.css` da `webapp/src/` a `multimedia/` 
12. Copia `index.html` in `download/completi/`

---

## PARTE 6: Spostamento e Rinomina (mv)

### Comandi da conoscere:
- `mv <sorgente> <destinazione>` → Sposta un file
- `mv <vecchio_nome> <nuovo_nome>` → Rinomina
- `mv file1 file2 dir/` → Sposta più file

### 🎯 DA FARE (12 operazioni):

1. Rinomina `sistema/logs/sistema.log` in `sistema/logs/system.log`
2. Rinomina `sistema/logs/errori.log` in `sistema/logs/errors.log`
3. Sposta `download/completi/index.html` in `download/`
4. Rinomina `download/index.html` in `download/pagina_principale.html`
5. Sposta `note.txt` da `archivio/2024/` a `archivio/`
6. Rinomina `archivio/note.txt` in `archivio/appunti_2024.txt`
7. Sposta `multimedia/style.css` in `progetti/webapp/src/` (sovrascrive)
8. Rinomina la cartella `multimedia/video` in `multimedia/filmati`
9. Sposta tutti i file da `sistema/temp/` (se ce ne sono) in `download/in_corso/`
10. Rinomina `progetti/script/` in `progetti/scripts/`
11. Sposta `sistema/backup.sh` in `progetti/scripts/`
12. Rinomina `sistema/cleanup.sh` in `sistema/pulisci.sh`

---

## PARTE 7: Eliminazione File e Directory (rm)

### Comandi da conoscere:
- `rm <file>` → Elimina un file
- `rm -r <dir>` → Elimina una directory e il suo contenuto
- `rm -i <file>` → Chiede conferma prima di eliminare
- `rm -f <file>` → Forza l'eliminazione senza conferma

### 🎯 DA FARE (10 eliminazioni):

1. Elimina `documenti/lavoro/report/report_q4.txt`
2. Elimina `archivio/2024/report_q4.txt`
3. Crea un file `sistema/temp/test.txt` e poi eliminalo
4. Crea una cartella `sistema/temp/prova/` con dentro `file1.txt` e `file2.txt`, poi elimina TUTTA la cartella
5. Elimina `download/in_corso/` (dovrebbe essere vuota o quasi)
6. Crea ed elimina `multimedia/immagini/temp.jpg`
7. Elimina `sistema/pulisci.sh`
8. Elimina la cartella `archivio/2023/` (vuota)
9. Crea 3 file temporanei in `sistema/temp/` e eliminali con un solo comando usando wildcard
10. Elimina `progetti/webapp/settings.conf`

---

## PARTE 8: Permessi dei File (chmod, ls -l)

### Comandi da conoscere:
- `chmod +x <file>` → Aggiunge permesso di esecuzione
- `chmod 755 <file>` → rwxr-xr-x (tipico per script)
- `chmod 644 <file>` → rw-r--r-- (tipico per file)
- `chmod 600 <file>` → rw------- (file privato)
- `chmod -R 755 <dir>` → Applica ricorsivamente

### Notazione ottale:
- 4 = lettura (r)
- 2 = scrittura (w)  
- 1 = esecuzione (x)
- Somma: 7=rwx, 6=rw-, 5=r-x, 4=r--

### 🎯 DA FARE (10 modifiche):

1. Rendi eseguibile `progetti/scripts/backup.sh` con `chmod +x`
2. Imposta permessi 755 su `progetti/scripts/cleanup.sh`
3. Imposta permessi 600 su `sistema/config/settings.conf` (file privato)
4. Imposta permessi 644 su tutti i file in `documenti/lavoro/report/`
5. Crea un file `sistema/config/secret.key` e imposta permessi 600
6. Imposta permessi 755 sulla cartella `progetti/scripts/`
7. Rimuovi permesso di scrittura a "others" da `progetti/webapp/docs/README.md`
8. Imposta permessi 700 sulla cartella `sistema/config/` (solo proprietario)
9. Rendi tutti i file `.sh` eseguibili con un solo comando: `chmod +x progetti/scripts/*.sh`
10. Verifica i permessi con `ls -la` su ogni cartella modificata

---

## PARTE 9: Link Simbolici (ln)

### Comandi da conoscere:
- `ln -s <target> <nome_link>` → Crea un link simbolico
- `ls -l` → Mostra dove punta il link
- `readlink <link>` → Mostra il target del link

### 🎯 DA FARE (10 link):

1. Crea un link `link_report` in `documenti/` che punta a `lavoro/report/`
2. Crea un link `README` in `lab_linux/` che punta a `progetti/webapp/docs/README.md`
3. Crea un link `scripts` in `lab_linux/` che punta a `progetti/scripts/`
4. Crea un link `quick_config` in `lab_linux/` che punta a `sistema/config/settings.conf`
5. Crea un link `webapp_src` in `download/` che punta a `../progetti/webapp/src/`
6. Crea un link `logs` in `lab_linux/` che punta a `sistema/logs/`
7. Crea un link `archivio_corrente` in `documenti/` che punta a `archivio/2024/`
8. Crea un link `backup` in `progetti/` che punta a `backup_progetti/webapp/`
9. Crea un link `immagini` in `download/` che punta a `../multimedia/immagini/`
10. Verifica tutti i link con `ls -la`

---

## PARTE 10: Ricerca con Find e Wildcard (find, *, ?, [])

### Comandi da conoscere:
- `find <percorso> -name "pattern"` → Cerca per nome
- `find . -type f` → Cerca solo file
- `find . -type d` → Cerca solo directory
- `find . -name "*.txt"` → Tutti i file .txt
- `*` → Qualsiasi sequenza di caratteri
- `?` → Un singolo carattere
- `[abc]` → Uno tra a, b, c

### 🎯 DA FARE (10 ricerche):

1. Trova tutti i file `.txt` in `lab_linux/`
2. Trova tutti i file `.sh` 
3. Trova tutte le directory chiamate `src`
4. Trova tutti i file che iniziano con `report`
5. Trova tutti i file `.log` in `sistema/`
6. Trova tutte le directory vuote: `find . -type d -empty`
7. Trova tutti i file modificati negli ultimi 10 minuti: `find . -mmin -10`
8. Trova tutti i file con "backup" nel nome
9. Trova tutti i file `.html` o `.css` (usa `-o` per OR)
10. Conta quanti file `.txt` ci sono: `find . -name "*.txt" | wc -l`

---

## PARTE 11: Ricerca nel Contenuto (grep)

### Comandi da conoscere:
- `grep "pattern" <file>` → Cerca pattern nel file
- `grep -r "pattern" <dir>` → Ricerca ricorsiva
- `grep -i "pattern" <file>` → Case insensitive
- `grep -l "pattern" *` → Mostra solo nomi file
- `grep -n "pattern" <file>` → Mostra numeri di riga
- `grep -c "pattern" <file>` → Conta occorrenze

### 🎯 DA FARE (10 ricerche):

1. Cerca "SUPERATO" in tutti i file report
2. Cerca "echo" in tutti i file `.sh`
3. Cerca "color" (case insensitive) in `style.css`
4. Cerca "Versione" in tutto `lab_linux/` ricorsivamente
5. Conta quante volte appare "backup" nei file di configurazione
6. Trova tutti i file che contengono "function"
7. Cerca "TODO" o "FIXME" in tutti i file (case insensitive)
8. Mostra le righe che contengono numeri in `settings.conf`
9. Cerca "html" in tutti i file e mostra il numero di riga
10. Usa grep con pipe: `cat report_q*.txt | grep "Vendite"`

---

## PARTE 12: Pipe e Redirezione (|, >, >>)

### Comandi da conoscere:
- `cmd1 | cmd2` → L'output di cmd1 diventa input di cmd2
- `cmd > file` → Scrive output su file (sovrascrive)
- `cmd >> file` → Aggiunge output a file
- `cmd 2> file` → Redirige errori
- `cmd &> file` → Redirige tutto (output + errori)

### 🎯 DA FARE (10 utilizzi):

1. `ls -la | grep ".txt"` → Lista solo i file .txt
2. `cat report_q*.txt | sort` → Concatena e ordina
3. `find . -name "*.sh" | wc -l` → Conta gli script
4. `ls -la > documenti/lista_file.txt` → Salva lista su file
5. `echo "Log di oggi" >> sistema/logs/system.log` → Aggiungi al log
6. `cat *.txt | grep -i "euro" | sort` → Cerca, filtra e ordina
7. `find . -type f | head -10` → Mostra primi 10 file trovati
8. `ls -lS | head -5` → I 5 file più grandi
9. `cat sistema/logs/*.log | tail -20` → Ultime 20 righe dei log
10. `grep -r "TODO" . 2>/dev/null | tee todo_list.txt` → Cerca e salva

---

## PARTE 13: Compressione e Archivi (zip, unzip, tar)

### Comandi da conoscere:
- `zip archivio.zip file1 file2` → Crea ZIP
- `zip -r archivio.zip cartella/` → ZIP ricorsivo
- `unzip archivio.zip` → Estrai ZIP
- `unzip -l archivio.zip` → Lista contenuto senza estrarre
- `unzip archivio.zip -d dest/` → Estrai in cartella specifica
- `tar -cvf archivio.tar cartella/` → Crea TAR
- `tar -xvf archivio.tar` → Estrai TAR
- `tar -czvf archivio.tar.gz cartella/` → Crea TAR compresso

### 🎯 DA FARE (10 operazioni):

Prima installa zip se necessario:
```
bash
sudo apt update
sudo apt install zip unzip -y
```
1. Crea `report_backup.zip` contenente tutti i file report
2. Crea `webapp_backup.zip` contenente tutta la cartella `webapp/`
3. Lista il contenuto di `webapp_backup.zip` senza estrarre
4. Estrai `report_backup.zip` in `download/completi/`
5. Crea `scripts.tar` contenente la cartella `scripts/`
6. Crea `progetti_full.tar.gz` (compresso) di tutta `progetti/`
7. Estrai `scripts.tar` in `sistema/temp/`
8. Crea un archivio `logs.zip` dei file log
9. Crea `archivio_documenti.tar.gz` di `documenti/archivio/`
10. Verifica l'integrità di uno ZIP: `unzip -t report_backup.zip`

---

## PARTE 14: Hash e Verifica Integrità (md5sum, sha256sum)

### Comandi da conoscere:
- `md5sum <file>` → Calcola hash MD5
- `sha256sum <file>` → Calcola hash SHA256 (più sicuro)
- `md5sum file1 file2` → Hash di più file
- `md5sum -c file.md5` → Verifica hash da file

### 🎯 DA FARE (10 operazioni):

1. Calcola l'hash MD5 di `report_q1.txt`
2. Calcola l'hash SHA256 di `settings.conf`
3. Calcola l'hash di TUTTI i file in `progetti/webapp/src/`
4. Salva gli hash in un file: `md5sum progetti/webapp/src/* > webapp_hashes.md5`
5. Verifica gli hash: `md5sum -c webapp_hashes.md5`
6. Modifica leggermente un file e ricalcola l'hash (vedrai che cambia!)
7. Calcola l'hash di `webapp_backup.zip`
8. Confronta gli hash di due file per vedere se sono identici
9. Crea un file `checksums.sha256` con gli hash SHA256 dei file importanti
10. Salva l'hash di `progetti_full.tar.gz` per verifica futura

---

## PARTE 15: Crittografia (gpg)

### Comandi da conoscere:
- `gpg -c <file>` → Cripta con password (simmetrico)
- `gpg -d <file.gpg>` → Decripta
- `gpg -o output.txt -d file.gpg` → Decripta su file

### 🎯 DA FARE (10 operazioni):

Prima verifica che gpg sia installato:
```
bash
gpg --version
```
1. Cripta `sistema/config/secret.key` (scegli una password semplice per il test)
2. Elimina l'originale `secret.key` (ora hai solo la versione criptata)
3. Decripta `secret.key.gpg` e verifica il contenuto
4. Cripta `settings.conf` 
5. Cripta tutti i file report in un archivio: prima `zip report.zip report_q*.txt`, poi `gpg -c report.zip`
6. Decripta `report.zip.gpg` in `download/`
7. Crea un file `password_segrete.txt` con contenuto sensibile, criptalo e elimina l'originale
8. Decripta `password_segrete.txt.gpg` e visualizza il contenuto con `gpg -d` (senza salvare)
9. Cripta la cartella `sistema/config/` (prima fai tar, poi gpg)
10. Prova a decriptare con password sbagliata (vedrai l'errore)

---

## PARTE 16: Gestione Processi (ps, htop, kill)

### Comandi da conoscere:
- `ps` → Processi della sessione
- `ps aux` → Tutti i processi
- `ps aux | grep <nome>` → Cerca processo specifico
- `htop` → Monitor interattivo (installa con `sudo apt install htop`)
- `kill <PID>` → Termina processo (gentile)
- `kill -9 <PID>` → Termina forzato
- `killall <nome>` → Termina tutti i processi con quel nome

### 🎯 DA FARE (10 operazioni):
```
bash
sudo apt install htop -y
```
1. Visualizza tutti i processi con `ps aux`
2. Filtra i processi dell'utente corrente: `ps aux | grep $USER`
3. Avvia `htop` e esplora l'interfaccia
4. In htop: ordina per CPU (F6)
5. In htop: ordina per memoria
6. In htop: cerca un processo (F3)
7. Avvia un processo in background: `sleep 300 &`
8. Trova il PID del processo sleep: `ps aux | grep sleep`
9. Termina il processo sleep con `kill <PID>`
10. Verifica che sia terminato con `ps aux | grep sleep`

---

## PARTE 17: Installazione Pacchetti (apt)

### Comandi da conoscere:
- `sudo apt update` → Aggiorna lista pacchetti
- `sudo apt install <pacchetto>` → Installa
- `sudo apt remove <pacchetto>` → Rimuovi
- `sudo apt upgrade` → Aggiorna tutti i pacchetti
- `apt search <termine>` → Cerca pacchetti
- `apt show <pacchetto>` → Info su pacchetto

### 🎯 DA FARE (10 operazioni):

1. Aggiorna la lista dei pacchetti: `sudo apt update`
2. Cerca pacchetti relativi a "editor": `apt search editor`
3. Visualizza info su `nano`: `apt show nano`
4. Installa `tree` (utile per visualizzare struttura cartelle): `sudo apt install tree -y`
5. Usa tree: `tree ~/lab_linux`
6. Installa `ncdu` (analizzatore spazio disco): `sudo apt install ncdu -y`
7. Usa ncdu: `ncdu ~/lab_linux`
8. Visualizza i pacchetti installati: `apt list --installed | head -20`
9. Cerca pacchetti per "zip": `apt search zip | head -10`
10. Rimuovi un pacchetto di test (opzionale): `sudo apt remove ncdu`

---

## Verifica Finale

Quando hai completato tutto, esegui lo script di verifica:
```
bash
chmod +x verifica.sh
./verifica.sh ~/lab_linux
```
---

## Riepilogo Comandi Usati

| Comando | Utilizzi | Descrizione |
|---------|----------|-------------|
| `cd` | 15+ | Navigazione |
| `pwd` | 10+ | Mostra percorso |
| `mkdir` | 15+ | Crea directory |
| `touch` | 15 | Crea file vuoti |
| `nano` | 10 | Editor di testo |
| `cat` | 10+ | Visualizza/concatena |
| `ls` | 15+ | Lista file |
| `cp` | 12 | Copia |
| `mv` | 12 | Sposta/rinomina |
| `rm` | 10 | Elimina |
| `chmod` | 10 | Permessi |
| `ln -s` | 10 | Link simbolici |
| `find` | 10 | Ricerca file |
| `grep` | 10 | Ricerca contenuto |
| `\|, >, >>` | 10 | Pipe e redirezione |
| `zip/unzip` | 10 | Compressione |
| `md5sum/sha256sum` | 10 | Hash |
| `gpg` | 10 | Crittografia |
| `ps/htop/kill` | 10 | Processi |
| `apt` | 10 | Pacchetti |

**Tempo stimato:** 1.5 - 2 ore

**Buon lavoro!** 🐧🎉
