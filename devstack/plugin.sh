# plugin.sh - DevStack plugin.sh script per il servizio "template"

function install_template {
    echo "Installazione del servizio template..."
    # Comando per installare cowsay usando apt (per Debian/Ubuntu) o yum (per RedHat/CentOS)
    if [[ -x "$(command -v apt-get)" ]]; then
        sudo apt-get update
        sudo apt-get install -y cowsay
    elif [[ -x "$(command -v yum)" ]]; then
        sudo yum install -y cowsay
    else
        echo "Errore: il gestore di pacchetti non è supportato."
        exit 1
    fi
}

function init_template {
    echo "Inizializzazione del servizio template..."
    # Controlla se cowsay è installato e funzionante
    if command -v cowsay >/dev/null 2>&1; then
        echo "Il servizio template (cowsay) è pronto per l'uso."
    else
        echo "Errore: il servizio template non è stato installato correttamente."
    fi
}

function configure_template {
    echo "Configurazione del servizio template..."
    # Configura cowsay per un messaggio di benvenuto personalizzato all'avvio
    echo 'cowsay "Benvenuto nel servizio template!"' > ~/template_welcome.sh
    chmod +x ~/template_welcome.sh
}

# Verifica se il servizio "template" è abilitato in DevStack
if is_service_enabled template; then
    if [[ "$1" == "stack" && "$2" == "pre-install" ]]; then
        echo "Installazione delle dipendenze di sistema per il servizio template..."
        # Installa eventuali dipendenze necessarie (ad esempio cowsay come servizio di esempio)
        install_package cowsay
    fi

    if [[ "$1" == "stack" && "$2" == "install" ]]; then
        echo "Eseguo install_template..."
        # Esegue l'installazione del servizio template
        install_template
    fi

    if [[ "$1" == "stack" && "$2" == "post-config" ]]; then
        echo "Eseguo configure_template..."
        # Esegue la configurazione dopo l'installazione
        configure_template
    fi

    if [[ "$1" == "stack" && "$2" == "extra" ]]; then
        echo "Eseguo init_template..."
        # Inizializza il servizio dopo la configurazione
        init_template
    fi

    if [[ "$1" == "unstack" ]]; then
        echo "Interruzione del servizio template..."
        # Comando per arrestare il servizio (esempio di arresto del servizio)
        sudo pkill -f cowsay || echo "Il servizio template non è attualmente in esecuzione."
    fi

    if [[ "$1" == "clean" ]]; then
        echo "Pulizia dei dati del servizio template..."
        # Comando per rimuovere file temporanei o dati di stato del servizio
        rm -f ~/template_welcome.sh
        sudo apt-get remove --purge -y cowsay || sudo yum remove -y cowsay
        echo "Il servizio template è stato rimosso correttamente."
    fi
fi

