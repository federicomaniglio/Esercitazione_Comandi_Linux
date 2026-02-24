#!/bin/bash

#╔════════════════════════════════════════════════════════════════════════════╗
#║                   VERIFICA ESERCITAZIONE LINUX                           ║
#║                   BEAUTIFUL & PROFESSIONAL VERSION                         ║
#╚════════════════════════════════════════════════════════════════════════════╝

# ─────────────────────────────────────────────────────────────────────────────
# COLORI E STILI AVANZATI
# ─────────────────────────────────────────────────────────────────────────────

# Colori primari
Black='\e[30m'
Red='\e[31m'
Green='\e[32m'
Yellow='\e[33m'
Blue='\e[34m'
Magenta='\e[35m'
Cyan='\e[36m'
White='\e[37m'

# Colori luminosi
BBlack='\e[90m'
BRed='\e[91m'
BGreen='\e[92m'
BYellow='\e[93m'
BBlue='\e[94m'
BMagenta='\e[95m'
BCyan='\e[96m'
BWhite='\e[97m'

# Sfondo
BG_Black='\e[40m'
BG_Red='\e[41m'
BG_Green='\e[42m'
BG_Yellow='\e[43m'
BG_Blue='\e[44m'
BG_Magenta='\e[45m'
BG_Cyan='\e[46m'
BG_White='\e[47m'

# Stili
Bold='\e[1m'
Dim='\e[2m'
Italic='\e[3m'
Underline='\e[4m'
Blink='\e[5m'
Reverse='\e[7m'
Hidden='\e[8m'
Strike='\e[9m'
Reset='\e[0m'

# Reset combinato
NC='\e[0m'

# Colori custom eleganti per questa app
PRIMARY='\e[38;5;33m'      # Blu elegante
SUCCESS='\e[38;5;46m'      # Verde luminoso
WARNING='\e[38;5;226m'     # Giallo dorato
ERROR='\e[38;5;196m'       # Rosso vivido
INFO='\e[38;5;51m'         # Cyan brillante
ACCENT='\e[38;5;207m'      # Magenta sofisticato
SUBTLE='\e[38;5;242m'      # Grigio scuro

# Emoji eleganti
CHECKMARK="✓"
CROSSMARK="✗"
WARNING_SIGN="⚠"
INFO_SIGN="ℹ"
GEAR="⚙"
FOLDER="📁"
FILE="📄"
LOCK="🔒"
LINK="🔗"
ARCHIVE="📦"
HASH="🔢"
ENCRYPT="🔐"

# ─────────────────────────────────────────────────────────────────────────────
# STATISTICHE
# ─────────────────────────────────────────────────────────────────────────────

PASSED=0
FAILED=0
WARNED=0
TOTAL=0

# Target directory
TARGET_DIR="${1:-$HOME/lab_linux}"

if [[ ! -d "$TARGET_DIR" ]]; then
    printf "\n${ERROR}${Bold}  ${CROSSMARK} ERRORE FATALE${NC}\n"
    printf "  ${Dim}La cartella '$TARGET_DIR' non esiste${NC}\n\n"
    exit 1
fi

cd "$TARGET_DIR" || exit 1

# ─────────────────────────────────────────────────────────────────────────────
# FUNZIONI DI OUTPUT ELEGANTI
# ─────────────────────────────────────────────────────────────────────────────

# Clearscreen e setup
clear_and_reset() {
    printf '\e[2J\e[3J\e[1;1H'
    printf '\e]0;Linux Verification Script\a'
}

# Separatori decorativi
print_divider_main() {
    printf "${PRIMARY}╔════════════════════════════════════════════════════════════════════════════╗${NC}\n"
}

print_divider_section() {
    printf "\n${Cyan}├─ ${Bold}$1${Cyan}${NC}\n"
}

print_divider_subsection() {
    printf "${Dim}${SUBTLE}  ┊ $1${NC}\n"
}

print_check() {
    printf "  ${SUCCESS}${Bold}${CHECKMARK}${NC}  ${Cyan}$1${NC}\n"
    ((PASSED++))
    ((TOTAL++))
}

print_cross() {
    printf "  ${ERROR}${Bold}${CROSSMARK}${NC}  ${Italic}$1${NC}\n"
    ((FAILED++))
    ((TOTAL++))
}

print_warn_msg() {
    printf "  ${WARNING}${Bold}${WARNING_SIGN}${NC}  ${Italic}${SUBTLE}$1${NC}\n"
    ((WARNED++))
    ((TOTAL++))
}

print_info_msg() {
    printf "  ${INFO}${Bold}${INFO_SIGN}${NC}  ${Dim}$1${NC}\n"
}

# ─────────────────────────────────────────────────────────────────────────────
# FUNZIONI DI VERIFICA
# ─────────────────────────────────────────────────────────────────────────────

get_permissions() {
    local path="$1"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        stat -f "%OAp" "$path" 2>/dev/null | tail -c 4
    else
        stat -c "%a" "$path" 2>/dev/null
    fi
}

human_readable() {
    local size=$1
    if [[ $size -lt 1024 ]]; then
        printf "%dB" "$size"
    elif [[ $size -lt 1048576 ]]; then
        printf "%dKB" "$((size / 1024))"
    elif [[ $size -lt 1073741824 ]]; then
        printf "%dMB" "$((size / 1048576))"
    else
        printf "%.1fGB" "$(echo "scale=1; $size / 1073741824" | bc 2>/dev/null || echo 0)"
    fi
}

check_dir() {
    local path="$1"
    if [[ -d "$path" ]]; then
        print_check "${FOLDER} $path"
        return 0
    else
        print_cross "${FOLDER} $path (mancante)"
        return 1
    fi
}

check_file() {
    local path="$1"
    if [[ -f "$path" ]]; then
        print_check "${FILE} $path"
        return 0
    else
        print_cross "${FILE} $path (mancante)"
        return 1
    fi
}

check_file_absent() {
    local path="$1"
    if [[ ! -e "$path" ]]; then
        print_check "Eliminato: $path"
        return 0
    else
        print_cross "Doveva essere eliminato: $path"
        return 1
    fi
}

check_dir_absent() {
    local path="$1"
    if [[ ! -d "$path" ]]; then
        print_check "Directory eliminata: $path"
        return 0
    else
        print_cross "Directory doveva essere eliminata: $path"
        return 1
    fi
}

check_symlink() {
    local path="$1"
    if [[ -L "$path" ]]; then
        local target=$(readlink "$path" 2>/dev/null || ls -l "$path" 2>/dev/null | awk '{print $(NF)}')
        print_check "${LINK} $path → $target"
        return 0
    else
        print_cross "${LINK} $path (mancante)"
        return 1
    fi
}

check_content() {
    local path="$1"
    local expected="$2"
    
    if [[ ! -f "$path" ]]; then
        print_cross "${FILE} $path (mancante)"
        return 1
    fi
    
    if grep -q "$expected" "$path" 2>/dev/null; then
        print_check "Contenuto OK: $path"
        return 0
    else
        print_cross "Contenuto errato: $path (manca: '$expected')"
        return 1
    fi
}

check_permission() {
    local path="$1"
    local expected_perm="$2"
    
    if [[ ! -e "$path" ]]; then
        print_cross "Permessi - file mancante: $path"
        return 1
    fi
    
    local actual_perm
    actual_perm=$(get_permissions "$path")
    
    if [[ "$actual_perm" == "$expected_perm" ]]; then
        print_check "Permessi OK: $path ($expected_perm)"
        return 0
    else
        print_warn_msg "Permessi: $path (atteso: $expected_perm, trovato: $actual_perm)"
        return 0
    fi
}

check_executable() {
    local path="$1"
    if [[ ! -f "$path" ]]; then
        print_cross "Script mancante: $path"
        return 1
    fi
    
    if [[ -x "$path" ]]; then
        print_check "Eseguibile: $path"
        return 0
    else
        print_cross "Non eseguibile: $path"
        return 1
    fi
}

check_file_or() {
    local path1="$1"
    local path2="$2"
    
    if [[ -f "$path1" ]]; then
        print_check "${FILE} $path1"
        return 0
    elif [[ -f "$path2" ]]; then
        print_check "${FILE} $path2"
        return 0
    else
        print_cross "${FILE} File mancante: $path1 o $path2"
        return 1
    fi
}

check_dir_or() {
    local path1="$1"
    local path2="$2"
    
    if [[ -d "$path1" ]]; then
        print_check "${FOLDER} $path1"
        return 0
    elif [[ -d "$path2" ]]; then
        print_warn_msg "${FOLDER} Directory trovata come: $path2 (non rinominata)"
        return 0
    else
        print_cross "${FOLDER} Directory mancante: $path1 o $path2"
        return 1
    fi
}

check_archive() {
    local path="$1"
    
    if [[ -f "$path" ]]; then
        local size
        size=$(stat -c "%s" "$path" 2>/dev/null || stat -f "%z" "$path" 2>/dev/null)
        if [[ $size -gt 0 ]]; then
            local human_size=$(human_readable "$size")
            print_check "${ARCHIVE} $path ($human_size)"
            return 0
        fi
    fi
    
    print_cross "${ARCHIVE} Archivio mancante o vuoto: $path"
    return 1
}

check_gpg() {
    local path="$1"
    if [[ -f "$path" && "$path" == *.gpg ]]; then
        print_check "${ENCRYPT} Criptato: $path"
        return 0
    else
        print_cross "${ENCRYPT} File criptato mancante: $path"
        return 1
    fi
}

check_hash_file() {
    local path="$1"
    
    if [[ -f "$path" ]]; then
        if grep -qE '^[a-f0-9]{32,64}' "$path" 2>/dev/null; then
            print_check "${HASH} Hash valido: $path"
            return 0
        fi
    fi
    
    print_cross "${HASH} File hash non valido: $path"
    return 1
}

check_command() {
    local cmd="$1"
    local name="$2"
    
    if which "$cmd" &> /dev/null; then
        print_check "${GEAR} $name installato"
        return 0
    else
        print_cross "${GEAR} $name NON installato"
        return 1
    fi
}

# ─────────────────────────────────────────────────────────────────────────────
# HEADER MAGNIFICO
# ─────────────────────────────────────────────────────────────────────────────

show_header() {
    clear_and_reset
    
    printf "\n"
    print_divider_main
    printf "${Primary}║                                                                            ║${NC}\n"
    printf "${PRIMARY}║${NC}  ${Bold} VERIFICA ESERCITAZIONE LINUX${NC}                                          ${PRIMARY}║${NC}\n"
    printf "${PRIMARY}║${NC}  ${Dim}Sistema di controllo completo e automatico${NC}                           ${PRIMARY}║${NC}\n"
    printf "${PRIMARY}║                                                                            ║${NC}\n"
    print_divider_main
    
    printf "\n${Cyan}${Bold} Informazioni Setup${NC}\n"
    printf "  ${Dim}Directory:${NC} ${ACCENT}$TARGET_DIR${NC}\n"
    printf "  ${Dim}Data/Ora:${NC}  ${ACCENT}$(date '+%d %B %Y - %H:%M:%S')${NC}\n"
    printf "  ${Dim}Utente:${NC}   ${ACCENT}$(whoami)${NC}\n"
    printf "  ${Dim}Sistema:${NC}  ${ACCENT}$(uname -s)${NC}\n\n"
}

# ─────────────────────────────────────────────────────────────────────────────
# SEZIONI DI VERIFICA
# ─────────────────────────────────────────────────────────────────────────────

# Setup initial script dir detection
SCRIPT_DIR="progetti/scripts"
[[ ! -d "$SCRIPT_DIR" ]] && SCRIPT_DIR="progetti/script"
[[ ! -d "$SCRIPT_DIR" ]] && SCRIPT_DIR=""

show_header

# ═══════════════════════════════════════════════════════════════════════════
print_divider_section "PARTE 1: Struttura Directory"
# ═══════════════════════════════════════════════════════════════════════════

print_divider_subsection "Directory principali"
check_dir "documenti"
check_dir "progetti"
check_dir "sistema"
check_dir "multimedia"
check_dir "download"

print_divider_subsection "Sottodirectory documenti"
check_dir "documenti/lavoro"
check_dir "documenti/lavoro/report"
check_dir "documenti/lavoro/presentazioni"
check_dir "documenti/personale"
check_dir "documenti/archivio"
check_dir "documenti/archivio/2024"

print_divider_subsection "Sottodirectory progetti"
check_dir "progetti/webapp"
check_dir "progetti/webapp/src"
check_dir "progetti/webapp/docs"
check_dir "progetti/webapp/test"
check_dir "progetti/backup_progetti"
check_dir_or "progetti/scripts" "progetti/script"

print_divider_subsection "Sottodirectory sistema"
check_dir "sistema/config"
check_dir "sistema/logs"
check_dir "sistema/temp"

print_divider_subsection "Sottodirectory multimedia"
check_dir "multimedia/immagini"
check_dir "multimedia/audio"
check_dir_or "multimedia/filmati" "multimedia/video"

print_divider_subsection "Sottodirectory download"
check_dir "download/completi"

# ═══════════════════════════════════════════════════════════════════════════
print_divider_section "PARTE 2-3: File e Contenuti"
# ═══════════════════════════════════════════════════════════════════════════

print_divider_subsection "Report"
check_file "documenti/lavoro/report/report_q1.txt"
check_file "documenti/lavoro/report/report_q2.txt"
check_file "documenti/lavoro/report/report_q3.txt"
check_content "documenti/lavoro/report/report_q1.txt" "Primo Trimestre"
check_content "documenti/lavoro/report/report_q2.txt" "Secondo Trimestre"

print_divider_subsection "Webapp"
check_file "progetti/webapp/src/index.html"
check_file "progetti/webapp/src/style.css"
check_file "progetti/webapp/src/app.js"
check_file "progetti/webapp/docs/README.md"
check_content "progetti/webapp/src/index.html" "DOCTYPE"

print_divider_subsection "Configurazione"
check_file "sistema/config/settings.conf"
check_content "sistema/config/settings.conf" "debug_mode"

print_divider_subsection "Log files"
check_file_or "sistema/logs/system.log" "sistema/logs/sistema.log"
check_file_or "sistema/logs/errors.log" "sistema/logs/errori.log"

# ═══════════════════════════════════════════════════════════════════════════
print_divider_section "PARTE 5: Copie"
# ═══════════════════════════════════════════════════════════════════════════

print_divider_subsection "Backup report"
check_file "documenti/archivio/2024/report_q1.txt"
check_file "documenti/archivio/2024/report_q2.txt"

print_divider_subsection "Backup webapp"
check_dir "progetti/backup_progetti/webapp"
check_dir "progetti/backup_progetti/webapp/src"

print_divider_subsection "Copie varie"
check_file "documenti/lavoro/README.md"
check_file "download/completi/index.html"

# ═══════════════════════════════════════════════════════════════════════════
print_divider_section "PARTE 6: Spostamenti e Rinominazioni"
# ═══════════════════════════════════════════════════════════════════════════

print_divider_subsection "File rinominati/spostati"
check_file_or "download/pagina_principale.html" "download/index.html"
check_file_or "documenti/archivio/appunti_2024.txt" "documenti/archivio/note.txt"

# ═══════════════════════════════════════════════════════════════════════════
print_divider_section "PARTE 7: Eliminazioni"
# ═══════════════════════════════════════════════════════════════════════════

print_divider_subsection "File eliminati"
check_file_absent "documenti/lavoro/report/report_q4.txt"
check_file_absent "documenti/archivio/2024/report_q4.txt"

print_divider_subsection "Directory eliminate"
check_dir_absent "documenti/archivio/2023"

# ═══════════════════════════════════════════════════════════════════════════
print_divider_section "PARTE 8: Permessi"
# ═══════════════════════════════════════════════════════════════════════════

print_divider_subsection "Script eseguibili"
if [[ -n "$SCRIPT_DIR" && -f "$SCRIPT_DIR/backup.sh" ]]; then
    check_executable "$SCRIPT_DIR/backup.sh"
fi
if [[ -n "$SCRIPT_DIR" && -f "$SCRIPT_DIR/cleanup.sh" ]]; then
    check_executable "$SCRIPT_DIR/cleanup.sh"
fi

print_divider_subsection "Permessi restrittivi"
check_permission "sistema/config/settings.conf" "600"
check_permission "sistema/config" "700"

# ═══════════════════════════════════════════════════════════════════════════
print_divider_section "PARTE 9: Link Simbolici"
# ═══════════════════════════════════════════════════════════════════════════

print_divider_subsection "Symlink"
check_symlink "documenti/link_report"
check_symlink "documenti/archivio_corrente"
check_symlink "README"
check_symlink "quick_config"
check_symlink "download/webapp_src"
check_symlink "download/immagini"
check_symlink "progetti/backup"

# ═══════════════════════════════════════════════════════════════════════════
print_divider_section "PARTE 13: Archivi"
# ═══════════════════════════════════════════════════════════════════════════

print_divider_subsection "ZIP files"
for zip_path in "report_backup.zip" "documenti/report_backup.zip" "webapp_backup.zip" "progetti/webapp_backup.zip"; do
    [[ -f "$zip_path" ]] && check_archive "$zip_path"
done

print_divider_subsection "TAR files"
for tar_file in "scripts.tar" "progetti/scripts.tar" "progetti_full.tar.gz" "archivio_documenti.tar.gz"; do
    [[ -f "$tar_file" ]] && check_archive "$tar_file"
done

# ═══════════════════════════════════════════════════════════════════════════
print_divider_section "PARTE 14: Hash"
# ═══════════════════════════════════════════════════════════════════════════

print_divider_subsection "Hash files"
for hash_file in "webapp_hashes.md5" "progetti/webapp_hashes.md5" "checksums.sha256" "progetti/checksums.sha256"; do
    [[ -f "$hash_file" ]] && check_hash_file "$hash_file"
done

# ═══════════════════════════════════════════════════════════════════════════
print_divider_section "PARTE 15: Crittografia"
# ═══════════════════════════════════════════════════════════════════════════

print_divider_subsection "File criptati"
for gpg_file in "sistema/config/secret.key.gpg" "report.zip.gpg" "password_segrete.txt.gpg"; do
    [[ -f "$gpg_file" ]] && check_gpg "$gpg_file"
done

# ═══════════════════════════════════════════════════════════════════════════
print_divider_section "PARTE 16: Pacchetti Installati"
# ═══════════════════════════════════════════════════════════════════════════

print_divider_subsection "Dipendenze"
check_command "htop" "htop"
check_command "tree" "tree"
check_command "zip" "zip"
check_command "gpg" "gpg"

# ─────────────────────────────────────────────────────────────────────────────
# FOOTER CON RISULTATI
# ─────────────────────────────────────────────────────────────────────────────

printf "\n"
print_divider_main

# Calcolo percentuale
if [[ $TOTAL -eq 0 ]]; then
    PERCENTAGE=0
else
    PERCENTAGE=$((PASSED * 100 / TOTAL))
fi

# Determinazione stato finale
if [[ $FAILED -eq 0 ]]; then
    STATUS="${SUCCESS}${Bold}✓ PERFETTO${NC}"
    STATUS_MSG="Tutti i test superati!"
    EMOJI="🎉"
elif [[ $PERCENTAGE -ge 80 ]]; then
    STATUS="${WARNING}${Bold}⚠ QUASI PERFETTO${NC}"
    STATUS_MSG="Ottimo lavoro, mancano pochi dettagli"
    EMOJI="👍"
elif [[ $PERCENTAGE -ge 60 ]]; then
    STATUS="${WARNING}${Bold}⚠ BUONO${NC}"
    STATUS_MSG="Buon inizio, continua così"
    EMOJI="📝"
else
    STATUS="${ERROR}${Bold}✗ INCOMPLETO${NC}"
    STATUS_MSG="C'è ancora lavoro da fare"
    EMOJI="⚠️"
fi

# Header risultati
printf "\n${PRIMARY}${Bold}  ${EMOJI} RISULTATI FINALI${NC}\n\n"
printf "  ${STATUS}  ${SUBTLE}${STATUS_MSG}${NC}\n\n"

# Statistiche in formato elegante
printf "${Cyan}┌──────────────────────────────────────────┐${NC}\n"
printf "${Cyan}│${NC}  ${Bold}Test superati${NC}      ${SUCCESS}${Bold}%3d${NC}  ${SUBTLE}/${TOTAL}${NC}                  ${Cyan}│${NC}\n" "$PASSED"
printf "${Cyan}│${NC}  ${Bold}Test falliti${NC}       ${ERROR}${Bold}%3d${NC}  ${SUBTLE}${NC}                      ${Cyan}│${NC}\n" "$FAILED"
printf "${Cyan}│${NC}  ${Bold}Avvisi${NC}             ${WARNING}${Bold}%3d${NC}  ${SUBTLE}${NC}                      ${Cyan}│${NC}\n" "$WARNED"
printf "${Cyan}│${NC}  ${Bold}Percentuale${NC}       ${INFO}${Bold}%3d%%${NC}  ${SUBTLE}${NC}                     ${Cyan}│${NC}\n" "$PERCENTAGE"
printf "${Cyan}└──────────────────────────────────────────┘${NC}\n"

# Messaggi finali
printf "\n"
if [[ $FAILED -gt 0 ]]; then
    printf "${WARNING}💡 Suggerimento:${NC} Rivedi gli errori (${ERROR}✗${NC}) e riprova!\n\n"
fi

if [[ $WARNED -gt 0 ]]; then
    printf "${INFO}📝 Nota:${NC} Gli avvisi (${WARNING}⚠${NC}) potrebbero richiedere attenzione.\n\n"
fi

# Easter egg finale
if [[ $FAILED -eq 0 ]]; then
    printf "${PRIMARY}┌──────────────────────────────────────────┐${NC}\n"
    printf "${PRIMARY}│${NC}  🐧 ${ACCENT}${Bold}Dì al prof:${NC}                        ${PRIMARY}│${NC}\n"
    printf "${PRIMARY}│${NC}                                          ${PRIMARY}│${NC}\n"
    printf "${PRIMARY}│${NC}  ${BOLD}\"I pinguini non volano,${NC}              ${PRIMARY}│${NC}\n"
    printf "${PRIMARY}│${NC}  ${BOLD} ma i miei comandi sì!\"${NC}              ${PRIMARY}│${NC}\n"
    printf "${PRIMARY}│${NC}                                          ${PRIMARY}│${NC}\n"
    printf "${PRIMARY}└──────────────────────────────────────────┘${NC}\n"
fi

printf "\n"

exit "$FAILED"
