#!/bin/bash
  
  #===============================================================================
  #  🔍 VERIFICA ESERCITAZIONE LINUX COMPLETA
  #  Controlla la struttura, i contenuti, i permessi e tutto il resto
  #===============================================================================
  
  set -e
  
  # Colori
  RED='\033[0;31m'
  GREEN='\033[0;32m'
  YELLOW='\033[1;33m'
  CYAN='\033[0;36m'
  BOLD='\033[1m'
  NC='\033[0m'
  
  # Contatori
  PASSED=0
  FAILED=0
  WARNED=0
  TOTAL=0
  
  # Cartella da verificare
  TARGET_DIR="${1:-$HOME/lab_linux}"
  
  if [[ ! -d "$TARGET_DIR" ]]; then
      echo -e "${RED}❌ ERRORE: La cartella '$TARGET_DIR' non esiste!${NC}"
      echo ""
      echo "Uso: $0 [percorso_cartella]"
      echo "Default: ~/lab_linux"
      exit 1
  fi
  
  cd "$TARGET_DIR"
  
  #-------------------------------------------------------------------------------
  # Funzioni di verifica
  #-------------------------------------------------------------------------------
  
  check_dir() {
      local path="$1"
      ((TOTAL++))
      
      if [[ -d "$path" ]]; then
          echo -e "  ${GREEN}✓${NC} Directory: $path"
          ((PASSED++))
          return 0
      else
          echo -e "  ${RED}✗${NC} Directory MANCANTE: $path"
          ((FAILED++))
          return 1
      fi
  }
  
  check_file() {
      local path="$1"
      ((TOTAL++))
      
      if [[ -f "$path" ]]; then
          echo -e "  ${GREEN}✓${NC} File: $path"
          ((PASSED++))
          return 0
      else
          echo -e "  ${RED}✗${NC} File MANCANTE: $path"
          ((FAILED++))
          return 1
      fi
  }
  
  check_file_absent() {
      local path="$1"
      ((TOTAL++))
      
      if [[ ! -e "$path" ]]; then
          echo -e "  ${GREEN}✓${NC} Correttamente eliminato: $path"
          ((PASSED++))
          return 0
      else
          echo -e "  ${RED}✗${NC} Doveva essere eliminato: $path"
          ((FAILED++))
          return 1
      fi
  }
  
  check_dir_absent() {
      local path="$1"
      ((TOTAL++))
      
      if [[ ! -d "$path" ]]; then
          echo -e "  ${GREEN}✓${NC} Directory correttamente eliminata: $path"
          ((PASSED++))
          return 0
      else
          echo -e "  ${RED}✗${NC} Directory doveva essere eliminata: $path"
          ((FAILED++))
          return 1
      fi
  }
  
  check_symlink() {
      local path="$1"
      ((TOTAL++))
      
      if [[ -L "$path" ]]; then
          local target=$(readlink "$path")
          echo -e "  ${GREEN}✓${NC} Symlink: $path -> $target"
          ((PASSED++))
          return 0
      else
          echo -e "  ${RED}✗${NC} Symlink MANCANTE: $path"
          ((FAILED++))
          return 1
      fi
  }
  
  check_content() {
      local path="$1"
      local expected="$2"
      ((TOTAL++))
      
      if [[ ! -f "$path" ]]; then
          echo -e "  ${RED}✗${NC} File mancante per verifica contenuto: $path"
          ((FAILED++))
          return 1
      fi
      
      if grep -q "$expected" "$path" 2>/dev/null; then
          echo -e "  ${GREEN}✓${NC} Contenuto OK: $path (contiene '$expected')"
          ((PASSED++))
          return 0
      else
          echo -e "  ${RED}✗${NC} Contenuto ERRATO: $path (manca '$expected')"
          ((FAILED++))
          return 1
      fi
  }
  
  check_permission() {
      local path="$1"
      local expected_perm="$2"
      ((TOTAL++))
      
      if [[ ! -e "$path" ]]; then
          echo -e "  ${RED}✗${NC} File/dir mancante per verifica permessi: $path"
          ((FAILED++))
          return 1
      fi
      
      local actual_perm=$(stat -c "%a" "$path" 2>/dev/null)
      
      if [[ "$actual_perm" == "$expected_perm" ]]; then
          echo -e "  ${GREEN}✓${NC} Permessi OK: $path ($expected_perm)"
          ((PASSED++))
          return 0
      else
          echo -e "  ${YELLOW}⚠${NC} Permessi diversi: $path (atteso: $expected_perm, trovato: $actual_perm)"
          ((WARNED++))
          ((PASSED++))  # Non fallisce, solo warning
          return 0
      fi
  }
  
  check_executable() {
      local path="$1"
      ((TOTAL++))
      
      if [[ ! -f "$path" ]]; then
          echo -e "  ${RED}✗${NC} File mancante: $path"
          ((FAILED++))
          return 1
      fi
      
      if [[ -x "$path" ]]; then
          echo -e "  ${GREEN}✓${NC} Eseguibile: $path"
          ((PASSED++))
          return 0
      else
          echo -e "  ${RED}✗${NC} NON eseguibile: $path"
          ((FAILED++))
          return 1
      fi
  }
  
  check_file_or() {
      local path1="$1"
      local path2="$2"
      ((TOTAL++))
      
      if [[ -f "$path1" ]]; then
          echo -e "  ${GREEN}✓${NC} File: $path1"
          ((PASSED++))
          return 0
      elif [[ -f "$path2" ]]; then
          echo -e "  ${GREEN}✓${NC} File: $path2"
          ((PASSED++))
          return 0
      else
          echo -e "  ${RED}✗${NC} File MANCANTE: $path1 o $path2"
          ((FAILED++))
          return 1
      fi
  }
  
  check_dir_or() {
      local path1="$1"
      local path2="$2"
      ((TOTAL++))
      
      if [[ -d "$path1" ]]; then
          echo -e "  ${GREEN}✓${NC} Directory: $path1"
          ((PASSED++))
          return 0
      elif [[ -d "$path2" ]]; then
          echo -e "  ${YELLOW}⚠${NC} Directory non rinominata: trovato $path2 invece di $path1"
          ((WARNED++))
          ((PASSED++))
          return 0
      else
          echo -e "  ${RED}✗${NC} Directory MANCANTE: $path1 o $path2"
          ((FAILED++))
          return 1
      fi
  }
  
  check_archive_exists() {
      local path="$1"
      ((TOTAL++))
      
      if [[ -f "$path" ]]; then
          local size=$(stat -c "%s" "$path" 2>/dev/null)
          if [[ $size -gt 0 ]]; then
              echo -e "  ${GREEN}✓${NC} Archivio: $path ($(numfmt --to=iec $size 2>/dev/null || echo "${size}B"))"
              ((PASSED++))
              return 0
          fi
      fi
      
      echo -e "  ${RED}✗${NC} Archivio MANCANTE o vuoto: $path"
      ((FAILED++))
      return 1
  }
  
  check_gpg_file() {
      local path="$1"
      ((TOTAL++))
      
      if [[ -f "$path" ]] && [[ "$path" == *.gpg ]]; then
          echo -e "  ${GREEN}✓${NC} File criptato: $path"
          ((PASSED++))
          return 0
      else
          echo -e "  ${RED}✗${NC} File criptato MANCANTE: $path"
          ((FAILED++))
          return 1
      fi
  }
  
  check_hash_file() {
      local path="$1"
      ((TOTAL++))
      
      if [[ -f "$path" ]]; then
          # Verifica che contenga hash validi (32 o 64 caratteri hex)
          if grep -qE '^[a-f0-9]{32,64}' "$path" 2>/dev/null; then
              echo -e "  ${GREEN}✓${NC} File hash valido: $path"
              ((PASSED++))
              return 0
          fi
      fi
      
      echo -e "  ${RED}✗${NC} File hash MANCANTE o non valido: $path"
      ((FAILED++))
      return 1
  }
  
  check_symlink_or() {
      local path1="$1"
      local path2="$2"
      ((TOTAL++))
      
      if [[ -L "$path1" ]]; then
          local target=$(readlink "$path1")
          echo -e "  ${GREEN}✓${NC} Symlink: $path1 -> $target"
          ((PASSED++))
          return 0
      elif [[ -L "$path2" ]]; then
          local target=$(readlink "$path2")
          echo -e "  ${GREEN}✓${NC} Symlink: $path2 -> $target"
          ((PASSED++))
          return 0
      else
          echo -e "  ${RED}✗${NC} Symlink MANCANTE: $path1 o $path2"
          ((FAILED++))
          return 1
      fi
  }
  
  section_header() {
      echo ""
      echo -e "${CYAN}═══════════════════════════════════════════════════════════════${NC}"
      echo -e "${BOLD}$1${NC}"
      echo -e "${CYAN}═══════════════════════════════════════════════════════════════${NC}"
  }
  
  subsection_header() {
      echo ""
      echo -e "${YELLOW}─── $1 ───${NC}"
  }
  
  #-------------------------------------------------------------------------------
  # Inizio verifica
  #-------------------------------------------------------------------------------
  
  clear
  echo -e "${CYAN}"
  echo "╔═══════════════════════════════════════════════════════════════════════════╗"
  echo "║                                                                           ║"
  echo "║        🔍 VERIFICA ESERCITAZIONE LINUX COMPLETA 🔍                        ║"
  echo "║                                                                           ║"
  echo "╚═══════════════════════════════════════════════════════════════════════════╝"
  echo -e "${NC}"
  echo "📁 Verificando: $TARGET_DIR"
  echo "⏰ Data: $(date)"
  
  #===============================================================================
  section_header "📁 PARTE 1: Struttura Directory (mkdir)"
  #===============================================================================
  
  subsection_header "Directory principali"
  check_dir "documenti"
  check_dir "progetti"
  check_dir "sistema"
  check_dir "multimedia"
  check_dir "download"
  
  subsection_header "Sottodirectory documenti/"
  check_dir "documenti/lavoro"
  check_dir "documenti/lavoro/report"
  check_dir "documenti/lavoro/presentazioni"
  check_dir "documenti/personale"
  check_dir "documenti/archivio"
  check_dir "documenti/archivio/2024"
  
  subsection_header "Sottodirectory progetti/"
  check_dir "progetti/webapp"
  check_dir "progetti/webapp/src"
  check_dir "progetti/webapp/docs"
  check_dir "progetti/webapp/test"
  check_dir "progetti/backup_progetti"
  
  # scripts potrebbe essere stato rinominato da script (PARTE 6.10)
  check_dir_or "progetti/scripts" "progetti/script"
  
  # Determina quale directory script esiste per controlli successivi
  SCRIPT_DIR="progetti/scripts"
  [[ ! -d "$SCRIPT_DIR" ]] && SCRIPT_DIR="progetti/script"
  
  subsection_header "Sottodirectory sistema/"
  check_dir "sistema/config"
  check_dir "sistema/logs"
  check_dir "sistema/temp"
  
  subsection_header "Sottodirectory multimedia/"
  check_dir "multimedia/immagini"
  check_dir "multimedia/audio"
  # video dovrebbe essere stato rinominato in filmati (PARTE 6.8)
  check_dir_or "multimedia/filmati" "multimedia/video"
  
  subsection_header "Sottodirectory download/"
  check_dir "download/completi"
  # download/in_corso viene eliminato in PARTE 7.5, quindi verifichiamo che sia assente
  # Ma potrebbe non essere stato ancora eliminato, quindi non lo verifichiamo come assente
  
  #===============================================================================
  section_header "📄 PARTE 2: File Creati (touch)"
  #===============================================================================
  
  subsection_header "File report"
  check_file "documenti/lavoro/report/report_q1.txt"
  check_file "documenti/lavoro/report/report_q2.txt"
  check_file "documenti/lavoro/report/report_q3.txt"
  # report_q4.txt viene eliminato in PARTE 7, verificato dopo
  
  subsection_header "File presentazioni"
  check_file "documenti/lavoro/presentazioni/slide_intro.pptx"
  
  subsection_header "File personali"
  check_file "documenti/personale/note.txt"
  
  subsection_header "File webapp"
  check_file "progetti/webapp/src/index.html"
  check_file "progetti/webapp/src/style.css"
  check_file "progetti/webapp/src/app.js"
  check_file "progetti/webapp/docs/README.md"
  
  subsection_header "File script"
  if [[ -d "$SCRIPT_DIR" ]]; then
      check_file "$SCRIPT_DIR/backup.sh"
      check_file "$SCRIPT_DIR/cleanup.sh"
  fi
  
  subsection_header "File sistema"
  # sistema.log rinominato in system.log (PARTE 6.1)
  check_file_or "sistema/logs/system.log" "sistema/logs/sistema.log"
  # errori.log rinominato in errors.log (PARTE 6.2)
  check_file_or "sistema/logs/errors.log" "sistema/logs/errori.log"
  check_file "sistema/config/settings.conf"
  
  #===============================================================================
  section_header "📝 PARTE 3: Contenuti File (nano)"
  #===============================================================================
  
  subsection_header "Contenuto report"
  check_content "documenti/lavoro/report/report_q1.txt" "Primo Trimestre"
  check_content "documenti/lavoro/report/report_q1.txt" "SUPERATO"
  check_content "documenti/lavoro/report/report_q2.txt" "Secondo Trimestre"
  check_content "documenti/lavoro/report/report_q2.txt" "SUPERATO"
  
  subsection_header "Contenuto file personali"
  check_content "documenti/personale/note.txt" "Note personali"
  
  subsection_header "Contenuto webapp"
  check_content "progetti/webapp/src/index.html" "DOCTYPE"
  check_content "progetti/webapp/src/index.html" "<html>"
  check_content "progetti/webapp/src/index.html" "Benvenuto"
  check_content "progetti/webapp/src/style.css" "font-family"
  check_content "progetti/webapp/src/style.css" "background-color"
  check_content "progetti/webapp/src/app.js" "console.log"
  check_content "progetti/webapp/src/app.js" "function"
  check_content "progetti/webapp/docs/README.md" "WebApp"
  check_content "progetti/webapp/docs/README.md" "Versione"
  
  subsection_header "Contenuto script"
  if [[ -f "$SCRIPT_DIR/backup.sh" ]]; then
      check_content "$SCRIPT_DIR/backup.sh" "#!/bin/bash"
      check_content "$SCRIPT_DIR/backup.sh" "echo"
      check_content "$SCRIPT_DIR/backup.sh" "Backup"
  fi
  
  if [[ -f "$SCRIPT_DIR/cleanup.sh" ]]; then
      check_content "$SCRIPT_DIR/cleanup.sh" "#!/bin/bash"
      check_content "$SCRIPT_DIR/cleanup.sh" "echo"
  fi
  
  subsection_header "Contenuto configurazione"
  check_content "sistema/config/settings.conf" "debug_mode"
  check_content "sistema/config/settings.conf" "log_level"
  check_content "sistema/config/settings.conf" "max_connections"
  
  #===============================================================================
  section_header "📋 PARTE 5: Copie (cp)"
  #===============================================================================
  
  subsection_header "Copie report in archivio"
  check_file "documenti/archivio/2024/report_q1.txt"
  check_file "documenti/archivio/2024/report_q2.txt"
  check_file "documenti/archivio/2024/report_q3.txt"
  # report_q4.txt in archivio viene eliminato in PARTE 7.2
  
  subsection_header "Backup webapp"
  check_dir "progetti/backup_progetti/webapp"
  check_dir "progetti/backup_progetti/webapp/src"
  check_dir "progetti/backup_progetti/webapp/docs"
  check_dir "progetti/backup_progetti/webapp/test"
  
  subsection_header "Altre copie"
  # backup.sh copiato in sistema/ poi spostato in scripts (PARTE 6.11)
  # cleanup.sh copiato in sistema/ poi rinominato pulisci.sh e eliminato
  check_file "documenti/lavoro/README.md"
  check_file "download/completi/index.html"
  
  #===============================================================================
  section_header "🔄 PARTE 6: Spostamenti/Rinominazioni (mv)"
  #===============================================================================
  
  subsection_header "File rinominati"
  # sistema.log -> system.log (già verificato sopra)
  # errori.log -> errors.log (già verificato sopra)
  
  subsection_header "File spostati"
  # download/completi/index.html -> download/index.html -> download/pagina_principale.html
  check_file_or "download/pagina_principale.html" "download/index.html"
  
  # note.txt da archivio/2024/ a archivio/ e rinominato appunti_2024.txt
  check_file_or "documenti/archivio/appunti_2024.txt" "documenti/archivio/note.txt"
  
  subsection_header "Directory rinominate"
  # video -> filmati (già verificato sopra con check_dir_or)
  # script -> scripts (già verificato sopra con check_dir_or)
  
  #===============================================================================
  section_header "🗑️ PARTE 7: Eliminazioni (rm)"
  #===============================================================================
  
  subsection_header "File eliminati"
  check_file_absent "documenti/lavoro/report/report_q4.txt"
  check_file_absent "documenti/archivio/2024/report_q4.txt"
  check_file_absent "sistema/pulisci.sh"
  
  subsection_header "Directory eliminate"
  check_dir_absent "documenti/archivio/2023"
  
  #===============================================================================
  section_header "🔐 PARTE 8: Permessi (chmod)"
  #===============================================================================
  
  subsection_header "Script eseguibili"
  if [[ -f "$SCRIPT_DIR/backup.sh" ]]; then
      check_executable "$SCRIPT_DIR/backup.sh"
  fi
  
  if [[ -f "$SCRIPT_DIR/cleanup.sh" ]]; then
      check_executable "$SCRIPT_DIR/cleanup.sh"
  fi
  
  subsection_header "File con permessi restrittivi"
  check_permission "sistema/config/settings.conf" "600"
  
  # secret.key potrebbe esistere con permessi 600
  if [[ -f "sistema/config/secret.key" ]]; then
      check_permission "sistema/config/secret.key" "600"
  elif [[ -f "sistema/config/secret.key.gpg" ]]; then
      echo -e "  ${GREEN}✓${NC} secret.key criptato (secret.key.gpg esiste)"
      ((TOTAL++))
      ((PASSED++))
  fi
  
  subsection_header "Directory con permessi restrittivi"
  check_permission "sistema/config" "700"
  
  subsection_header "Permessi directory script"
  if [[ -d "$SCRIPT_DIR" ]]; then
      check_permission "$SCRIPT_DIR" "755"
  fi
  
  #===============================================================================
  section_header "🔗 PARTE 9: Link Simbolici (ln)"
  #===============================================================================
  
  subsection_header "Link in documenti/"
  check_symlink "documenti/link_report"
  check_symlink "documenti/archivio_corrente"
  
  subsection_header "Link in lab_linux/"
  check_symlink "README"
  check_symlink_or "scripts" "link_scripts"
  check_symlink "quick_config"
  check_symlink_or "logs" "link_logs"
  
  subsection_header "Link in download/"
  check_symlink "download/webapp_src"
  check_symlink "download/immagini"
  
  subsection_header "Link in progetti/"
  check_symlink "progetti/backup"
  
  #===============================================================================
  section_header "🔍 PARTE 10-11: Ricerca (find, grep) - Verifica Manuale"
  #===============================================================================
  
  echo -e "  ${YELLOW}ℹ${NC} Le parti find e grep richiedono verifica manuale"
  echo -e "  ${YELLOW}ℹ${NC} Assicurati di aver eseguito tutti i comandi richiesti"
  
  #===============================================================================
  section_header "📝 PARTE 12: Pipe e Redirezione - Verifica Parziale"
  #===============================================================================
  
  subsection_header "File creati con redirezione"
  # lista_file.txt creato con ls -la > documenti/lista_file.txt
  if [[ -f "documenti/lista_file.txt" ]]; then
      check_file "documenti/lista_file.txt"
  else
      echo -e "  ${YELLOW}⚠${NC} documenti/lista_file.txt non trovato (opzionale)"
      ((WARNED++))
  fi
  
  # todo_list.txt creato con grep -r "TODO" . | tee todo_list.txt
  if [[ -f "todo_list.txt" ]]; then
      check_file "todo_list.txt"
  else
      echo -e "  ${YELLOW}⚠${NC} todo_list.txt non trovato (opzionale)"
      ((WARNED++))
  fi
  
  #===============================================================================
  section_header "📦 PARTE 13: Archivi (zip, tar)"
  #===============================================================================
  
  subsection_header "File ZIP"
  # Cerca in varie posizioni possibili
  FOUND_REPORT_ZIP=0
  for zip_path in "report_backup.zip" "documenti/report_backup.zip" "documenti/lavoro/report/report_backup.zip"; do
      if [[ -f "$zip_path" ]]; then
          check_archive_exists "$zip_path"
          FOUND_REPORT_ZIP=1
          break
      fi
  done
  if [[ $FOUND_REPORT_ZIP -eq 0 ]]; then
      echo -e "  ${RED}✗${NC} Archivio MANCANTE: report_backup.zip"
      ((TOTAL++))
      ((FAILED++))
  fi
  
  FOUND_WEBAPP_ZIP=0
  for zip_path in "webapp_backup.zip" "progetti/webapp_backup.zip"; do
      if [[ -f "$zip_path" ]]; then
          check_archive_exists "$zip_path"
          FOUND_WEBAPP_ZIP=1
          break
      fi
  done
  if [[ $FOUND_WEBAPP_ZIP -eq 0 ]]; then
      echo -e "  ${RED}✗${NC} Archivio MANCANTE: webapp_backup.zip"
      ((TOTAL++))
      ((FAILED++))
  fi
  
  subsection_header "File TAR"
  TAR_COUNT=0
  
  for tar_file in "scripts.tar" "progetti/scripts.tar" "progetti_full.tar.gz" "archivio_documenti.tar.gz" "documenti/archivio_documenti.tar.gz"; do
      if [[ -f "$tar_file" ]]; then
          check_archive_exists "$tar_file"
          ((TAR_COUNT++))
      fi
  done
  
  if [[ $TAR_COUNT -eq 0 ]]; then
      echo -e "  ${YELLOW}⚠${NC} Nessun archivio TAR trovato"
      ((WARNED++))
  elif [[ $TAR_COUNT -lt 2 ]]; then
      echo -e "  ${YELLOW}⚠${NC} Trovato solo $TAR_COUNT archivio TAR (attesi almeno 2)"
      ((WARNED++))
  fi
  
  subsection_header "File ZIP logs"
  FOUND_LOGS_ZIP=0
  for zip_path in "logs.zip" "sistema/logs.zip"; do
      if [[ -f "$zip_path" ]]; then
          check_archive_exists "$zip_path"
          FOUND_LOGS_ZIP=1
          break
      fi
  done
  if [[ $FOUND_LOGS_ZIP -eq 0 ]]; then
      echo -e "  ${YELLOW}⚠${NC} logs.zip non trovato (opzionale)"
      ((WARNED++))
  fi
  
  #===============================================================================
  section_header "🔢 PARTE 14: Hash (md5sum, sha256sum)"
  #===============================================================================
  
  subsection_header "File hash MD5"
  FOUND_MD5=0
  for hash_file in "webapp_hashes.md5" "progetti/webapp_hashes.md5"; do
      if [[ -f "$hash_file" ]]; then
          check_hash_file "$hash_file"
          FOUND_MD5=1
          break
      fi
  done
  if [[ $FOUND_MD5 -eq 0 ]]; then
      echo -e "  ${YELLOW}⚠${NC} webapp_hashes.md5 non trovato"
      ((WARNED++))
  fi
  
  subsection_header "File hash SHA256"
  FOUND_SHA=0
  for hash_file in "checksums.sha256" "progetti/checksums.sha256"; do
      if [[ -f "$hash_file" ]]; then
          check_hash_file "$hash_file"
          FOUND_SHA=1
          break
      fi
  done
  if [[ $FOUND_SHA -eq 0 ]]; then
      echo -e "  ${YELLOW}⚠${NC} checksums.sha256 non trovato"
      ((WARNED++))
  fi
  
  #===============================================================================
  section_header "🔒 PARTE 15: Crittografia (gpg)"
  #===============================================================================
  
  subsection_header "File criptati"
  GPG_COUNT=0
  
  # Cerca file GPG specifici menzionati nell'esercizio
  for gpg_file in "sistema/config/secret.key.gpg" "sistema/config/settings.conf.gpg" "report.zip.gpg" "password_segrete.txt.gpg"; do
      if [[ -f "$gpg_file" ]]; then
          check_gpg_file "$gpg_file"
          ((GPG_COUNT++))
      fi
  done
  
  # Cerca anche altri file .gpg
  for gpg_file in $(find . -name "*.gpg" -type f 2>/dev/null | head -5); do
      # Evita duplicati
      already_checked=0
      for checked in "sistema/config/secret.key.gpg" "sistema/config/settings.conf.gpg" "report.zip.gpg" "password_segrete.txt.gpg"; do
          if [[ "$gpg_file" == "./$checked" ]]; then
              already_checked=1
              break
          fi
      done
      if [[ $already_checked -eq 0 ]]; then
          check_gpg_file "$gpg_file"
          ((GPG_COUNT++))
      fi
  done
  
  if [[ $GPG_COUNT -eq 0 ]]; then
      echo -e "  ${YELLOW}⚠${NC} Nessun file .gpg trovato"
      ((WARNED++))
  else
      echo -e "  ${GREEN}ℹ${NC} Trovati $GPG_COUNT file criptati"
  fi
  
  #===============================================================================
  section_header "⚙️ PARTE 16-17: Processi e Pacchetti"
  #===============================================================================
  
  subsection_header "Verifica pacchetti installati"
  
  # Verifica htop
  ((TOTAL++))
  if command -v htop &> /dev/null; then
      echo -e "  ${GREEN}✓${NC} htop è installato"
      ((PASSED++))
  else
      echo -e "  ${RED}✗${NC} htop NON è installato (sudo apt install htop)"
      ((FAILED++))
  fi
  
  # Verifica tree
  ((TOTAL++))
  if command -v tree &> /dev/null; then
      echo -e "  ${GREEN}✓${NC} tree è installato"
      ((PASSED++))
  else
      echo -e "  ${YELLOW}⚠${NC} tree non è installato (opzionale: sudo apt install tree)"
      ((WARNED++))
      ((PASSED++))
  fi
  
  # Verifica zip/unzip
  ((TOTAL++))
  if command -v zip &> /dev/null && command -v unzip &> /dev/null; then
      echo -e "  ${GREEN}✓${NC} zip/unzip sono installati"
      ((PASSED++))
  else
      echo -e "  ${RED}✗${NC} zip/unzip NON sono installati (sudo apt install zip unzip)"
      ((FAILED++))
  fi
  
  # Verifica gpg
  ((TOTAL++))
  if command -v gpg &> /dev/null; then
      echo -e "  ${GREEN}✓${NC} gpg è installato"
      ((PASSED++))
  else
      echo -e "  ${RED}✗${NC} gpg NON è installato"
      ((FAILED++))
  fi
  
  #===============================================================================
  # RIEPILOGO FINALE
  #===============================================================================
  
  echo ""
  echo -e "${CYAN}═══════════════════════════════════════════════════════════════════════════${NC}"
  echo ""
  
  # Evita divisione per zero
  if [[ $TOTAL -eq 0 ]]; then
      PERCENTAGE=0
  else
      PERCENTAGE=$((PASSED * 100 / TOTAL))
  fi
  

if [[ $FAILED -eq 0 ]]; then
      echo -e "${GREEN}${BOLD}"
      echo "╔═══════════════════════════════════════════════════════════════════════════╗"
      echo "║                                                                           ║"
      echo "║             🎉 COMPLIMENTI! TUTTI I TEST SUPERATI! 🎉                     ║"
      echo "║                                                                           ║"
      echo "╚═══════════════════════════════════════════════════════════════════════════╝"
      echo -e "${NC}"

      # Easter egg per il professore
      echo ""
      echo -e "${CYAN}┌─────────────────────────────────────────────────────────────────────────────┐${NC}"
      echo -e "${CYAN}│${NC}  🐧 ${BOLD}Per confermare il completamento, dì al prof:${NC}                          ${CYAN}│${NC}"
      echo -e "${CYAN}│${NC}                                                                             ${CYAN}│${NC}"
      echo -e "${CYAN}│${NC}     ${YELLOW}\"I pinguini non volano, ma i miei comandi sì!\"${NC}                       ${CYAN}│${NC}"
      echo -e "${CYAN}│${NC}                                                                             ${CYAN}│${NC}"
      echo -e "${CYAN}└─────────────────────────────────────────────────────────────────────────────┘${NC}"

elif [[ $PERCENTAGE -ge 80 ]]; then
      echo -e "${YELLOW}${BOLD}"
      echo "╔═══════════════════════════════════════════════════════════════════════════╗"
      echo "║                                                                           ║"
      echo "║                  👍 OTTIMO LAVORO! Quasi perfetto!                        ║"
      echo "║                                                                           ║"
      echo "╚═══════════════════════════════════════════════════════════════════════════╝"
      echo -e "${NC}"
  elif [[ $PERCENTAGE -ge 60 ]]; then
      echo -e "${YELLOW}${BOLD}"
      echo "╔═══════════════════════════════════════════════════════════════════════════╗"
      echo "║                                                                           ║"
      echo "║                  📝 BUON LAVORO! Continua così!                           ║"
      echo "║                                                                           ║"
      echo "╚═══════════════════════════════════════════════════════════════════════════╝"
      echo -e "${NC}"
  else
      echo -e "${RED}${BOLD}"
      echo "╔═══════════════════════════════════════════════════════════════════════════╗"
      echo "║                                                                           ║"
      echo "║               ⚠️  C'è ancora lavoro da fare!                              ║"
      echo "║                                                                           ║"
      echo "╚═══════════════════════════════════════════════════════════════════════════╝"
      echo -e "${NC}"
  fi
  
  echo ""
  echo "┌─────────────────────────────────────────┐"
  echo "│            📊 RISULTATI                 │"
  echo "├─────────────────────────────────────────┤"
  printf "│  Test superati:  ${GREEN}%-5d${NC}                  │\n" $PASSED
  printf "│  Test falliti:   ${RED}%-5d${NC}                  │\n" $FAILED
  printf "│  Avvisi:         ${YELLOW}%-5d${NC}                  │\n" $WARNED
  printf "│  Totale:         %-5d                  │\n" $TOTAL
  printf "│  Percentuale:    ${BOLD}%d%%${NC}                    │\n" $PERCENTAGE
  echo "└─────────────────────────────────────────┘"
  echo ""
  
  if [[ $FAILED -gt 0 ]]; then
      echo -e "${YELLOW}💡 Suggerimento: Rivedi le parti in rosso e riprova!${NC}"
      echo ""
  fi
  
  if [[ $WARNED -gt 0 ]]; then
      echo -e "${YELLOW}📝 Nota: Gli avvisi (⚠) indicano elementi opzionali o con valori diversi da quelli attesi.${NC}"
      echo ""
  fi
  
  # Mostra struttura finale con tree se disponibile
  if command -v tree &> /dev/null; then
      echo -e "${CYAN}📁 Struttura attuale (primi 3 livelli):${NC}"
      echo ""
      tree -L 3 --dirsfirst 2>/dev/null | head -60
  fi
  
  exit $FAILED