#!/bin/bash

# Script de Recuperação de Acesso - Nginx Proxy Manager
# Uso: ./npm-reset-password.sh

set -e  # Para o script se qualquer comando falhar

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Funções de utilidade
print_header() {
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}========================================${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_info() {
    echo -e "${YELLOW}ℹ️ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️ $1${NC}"
}

# Verificar dependências
check_dependencies() {
    print_header "Verificando dependências"
    
    if ! command -v docker &> /dev/null; then
        print_error "Docker não encontrado. Instale o Docker primeiro."
        exit 1
    fi
    print_success "Docker encontrado"
    
    # Verificar Python e bcrypt
    if command -v python3 &> /dev/null; then
        HAS_PYTHON=true
        # Verificar se o módulo bcrypt está instalado
        if ! python3 -c "import bcrypt" 2>/dev/null; then
            print_info "Instalando python3-bcrypt via pip..."
            pip3 install bcrypt 2>/dev/null || {
                print_warning "Não foi possível instalar via pip, tentando apt..."
                apt update && apt install -y python3-bcrypt 2>/dev/null
            }
        fi
        
        # Testar se bcrypt funciona
        if python3 -c "import bcrypt; bcrypt.hashpw('test'.encode(), bcrypt.gensalt())" 2>/dev/null; then
            print_success "Python3 com bcrypt configurado corretamente"
        else
            print_error "Python3 encontrado mas bcrypt não está funcionando"
            HAS_PYTHON=false
        fi
    else
        print_warning "Python3 não encontrado. Usando método alternativo para hash."
        HAS_PYTHON=false
    fi
}

# Listar containers NPM
list_npm_containers() {
    print_header "Procurando containers do Nginx Proxy Manager"
    
    # Lista todos os containers e filtra por nomes comuns do NPM
    CONTAINERS=$(docker ps --format "{{.Names}}" | grep -i "proxy-manager\|npm\|nginx-proxy-manager\|nginxproxymanager" || true)
    
    if [ -z "$CONTAINERS" ]; then
        print_error "Nenhum container do Nginx Proxy Manager encontrado em execução."
        print_info "Containers em execução:"
        docker ps --format "table {{.Names}}\t{{.Image}}"
        exit 1
    fi
    
    # Se houver múltiplos containers, deixar o usuário escolher
    CONTAINER_COUNT=$(echo "$CONTAINERS" | wc -l)
    
    if [ "$CONTAINER_COUNT" -eq 1 ]; then
        CONTAINER_NAME="$CONTAINERS"
        print_success "Container encontrado: $CONTAINER_NAME"
    else
        echo "Múltiplos containers encontrados. Selecione um:"
        select CONTAINER_NAME in $CONTAINERS; do
            if [ -n "$CONTAINER_NAME" ]; then
                print_success "Container selecionado: $CONTAINER_NAME"
                break
            else
                print_error "Opção inválida"
            fi
        done
    fi
}

# Instalar sqlite3 no container se necessário
install_sqlite_in_container() {
    print_info "Verificando sqlite3 no container..."
    
    if ! docker exec $CONTAINER_NAME which sqlite3 &> /dev/null; then
        print_info "Instalando sqlite3 no container..."
        
        # Tentar Alpine (apk)
        if docker exec $CONTAINER_NAME which apk &> /dev/null; then
            docker exec $CONTAINER_NAME sh -c "apk update && apk add sqlite" || {
                print_error "Falha ao instalar sqlite3 via apk"
                exit 1
            }
        # Tentar Debian/Ubuntu (apt)
        elif docker exec $CONTAINER_NAME which apt-get &> /dev/null; then
            docker exec $CONTAINER_NAME sh -c "apt-get update && apt-get install -y sqlite3" || {
                print_error "Falha ao instalar sqlite3 via apt"
                exit 1
            }
        else
            print_error "Não foi possível determinar o gerenciador de pacotes do container"
            exit 1
        fi
        print_success "sqlite3 instalado"
    else
        print_success "sqlite3 já está instalado"
    fi
}

# Gerar hash bcrypt
generate_bcrypt_hash() {
    local password=$1
    
    if [ "$HAS_PYTHON" = true ]; then
        # Usar Python com bcrypt
        python3 -c "
import bcrypt
import sys
try:
    # Gerar salt e hash
    salt = bcrypt.gensalt(rounds=12)
    hash = bcrypt.hashpw('$password'.encode('utf-8'), salt)
    print(hash.decode('utf-8'))
except Exception as e:
    print(f'Erro ao gerar hash: {e}', file=sys.stderr)
    sys.exit(1)
" 2>/dev/null
        if [ $? -ne 0 ]; then
            print_error "Falha ao gerar hash com Python"
            return 1
        fi
    else
        print_warning "Usando método alternativo (pode não funcionar em todas as versões)"
        # Método alternativo - gerar um hash básico (NÃO É BCRYPT, pode não funcionar)
        # Isso é apenas um fallback - o ideal é instalar Python
        echo "\$2y\$12\$"$(openssl rand -base64 22 | tr -d '\n/+=' | cut -c1-22)
    fi
}

# Opção 1: Criar novo usuário
create_new_user() {
    print_header "Criando novo usuário administrador"
    
    # Coletar dados do novo usuário
    read -p "Email do novo usuário: " NEW_EMAIL
    if [ -z "$NEW_EMAIL" ]; then
        print_error "Email não pode ser vazio"
        return 1
    fi
    
    read -sp "Senha para o novo usuário: " NEW_PASSWORD
    echo
    if [ -z "$NEW_PASSWORD" ]; then
        print_error "Senha não pode ser vazia"
        return 1
    fi
    
    read -sp "Confirme a senha: " NEW_PASSWORD_CONFIRM
    echo
    
    if [ "$NEW_PASSWORD" != "$NEW_PASSWORD_CONFIRM" ]; then
        print_error "As senhas não conferem"
        return 1
    fi
    
    # Gerar hash da senha
    print_info "Gerando hash da senha..."
    HASH=$(generate_bcrypt_hash "$NEW_PASSWORD")
    
    if [ -z "$HASH" ]; then
        print_error "Falha ao gerar hash da senha"
        return 1
    fi
    
    print_success "Hash gerado: $HASH"
    
    # Executar comandos SQL com debug
    print_info "Verificando se o email já existe..."
    EMAIL_EXISTS=$(docker exec $CONTAINER_NAME sqlite3 /data/database.sqlite "SELECT COUNT(*) FROM user WHERE email = '$NEW_EMAIL' AND is_deleted = 0;")
    
    if [ "$EMAIL_EXISTS" -gt 0 ]; then
        print_error "Email $NEW_EMAIL já está em uso"
        return 1
    fi
    
    print_info "Inserindo usuário no banco de dados..."
    
    # Criar um arquivo temporário com os comandos SQL
    TMP_SQL=$(mktemp)
    cat > $TMP_SQL << EOF
-- Inserir novo usuário
INSERT INTO user (email, name, nickname, avatar, is_disabled, is_deleted, created_at, updated_at)
VALUES ('$NEW_EMAIL', 'Admin User', 'admin', '', 0, 0, datetime('now'), datetime('now'));

-- Pegar o ID do novo usuário
SELECT 'ID_DO_NOVO_USUARIO: ' || last_insert_rowid();

-- Inserir senha
INSERT INTO auth (user_id, secret, type, created_at, updated_at)
VALUES (last_insert_rowid(), '$HASH', 'password', datetime('now'), datetime('now'));

-- Verificar resultado
SELECT 'RESULTADO: Usuário inserido com sucesso!';
SELECT 'EMAIL: $NEW_EMAIL';
SELECT 'HASH ARMAZENADO: ' || (SELECT secret FROM auth WHERE user_id = last_insert_rowid());

-- Listar todos os usuários para confirmar
SELECT 'TODOS OS USUÁRIOS:';
SELECT id, email, name FROM user WHERE is_deleted = 0;
EOF
    
    # Mostrar o SQL que será executado
    print_info "Comandos SQL a serem executados:"
    cat $TMP_SQL
    
    echo
    read -p "Deseja continuar com a execução? (s/N): " CONFIRM
    if [[ ! "$CONFIRM" =~ ^[Ss]$ ]]; then
        print_info "Operação cancelada"
        rm $TMP_SQL
        return 1
    fi
    
    # Executar SQL e capturar saída
    print_info "Executando comandos SQL..."
    SQL_OUTPUT=$(cat $TMP_SQL | docker exec -i $CONTAINER_NAME sqlite3 /data/database.sqlite 2>&1)
    SQL_EXIT_CODE=$?
    
    # Mostrar resultado
    echo -e "${YELLOW}Saída do SQLite:${NC}"
    echo "$SQL_OUTPUT"
    
    if [ $SQL_EXIT_CODE -ne 0 ]; then
        print_error "Erro ao executar SQL (código: $SQL_EXIT_CODE)"
        rm $TMP_SQL
        return 1
    fi
    
    rm $TMP_SQL
    
    # Verificar se o usuário foi criado
    FINAL_CHECK=$(docker exec $CONTAINER_NAME sqlite3 /data/database.sqlite "SELECT COUNT(*) FROM user WHERE email = '$NEW_EMAIL' AND is_deleted = 0;")
    
    if [ "$FINAL_CHECK" -gt 0 ]; then
        print_success "Usuário criado com sucesso!"
        print_info "Email: $NEW_EMAIL"
        
        # Verificar se a auth foi criada
        AUTH_CHECK=$(docker exec $CONTAINER_NAME sqlite3 /data/database.sqlite "SELECT COUNT(*) FROM auth WHERE user_id = (SELECT id FROM user WHERE email = '$NEW_EMAIL');")
        if [ "$AUTH_CHECK" -gt 0 ]; then
            print_success "Senha configurada com sucesso!"
        else
            print_error "ERRO: Senha não foi configurada corretamente!"
        fi
    else
        print_error "Falha ao criar usuário. Verifique os logs acima."
    fi
}

# Opção 2: Resetar senha de usuário existente
reset_existing_password() {
    print_header "Resetando senha de usuário existente"
    
    # Listar usuários existentes
    print_info "Usuários existentes no sistema:"
    docker exec $CONTAINER_NAME sqlite3 /data/database.sqlite "SELECT id, email, name FROM user WHERE is_deleted = 0 ORDER BY id;" | while IFS='|' read -r id email name; do
        echo "  ID: $id | Email: $email | Nome: $name"
    done
    
    echo
    read -p "Digite o ID do usuário que terá a senha resetada: " USER_ID
    
    # Verificar se usuário existe
    USER_EXISTS=$(docker exec $CONTAINER_NAME sqlite3 /data/database.sqlite "SELECT COUNT(*) FROM user WHERE id = $USER_ID AND is_deleted = 0;")
    
    if [ "$USER_EXISTS" -eq 0 ]; then
        print_error "Usuário não encontrado ou está deletado"
        return 1
    fi
    
    # Mostrar email do usuário selecionado
    USER_EMAIL=$(docker exec $CONTAINER_NAME sqlite3 /data/database.sqlite "SELECT email FROM user WHERE id = $USER_ID;")
    print_info "Resetando senha para: $USER_EMAIL"
    
    read -sp "Nova senha para o usuário: " NEW_PASSWORD
    echo
    read -sp "Confirme a nova senha: " NEW_PASSWORD_CONFIRM
    echo
    
    if [ "$NEW_PASSWORD" != "$NEW_PASSWORD_CONFIRM" ]; then
        print_error "As senhas não conferem"
        return 1
    fi
    
    # Gerar hash da senha
    print_info "Gerando hash da nova senha..."
    HASH=$(generate_bcrypt_hash "$NEW_PASSWORD")
    
    if [ -z "$HASH" ]; then
        print_error "Falha ao gerar hash da senha"
        return 1
    fi
    
    print_success "Hash gerado: $HASH"
    
    # Atualizar senha com debug
    print_info "Atualizando senha no banco de dados..."
    
    TMP_SQL=$(mktemp)
    cat > $TMP_SQL << EOF
-- Mostrar registro atual
SELECT 'AUTH ANTES:' FROM auth WHERE user_id = $USER_ID AND type = 'password';

-- Atualizar senha existente
UPDATE auth SET secret = '$HASH', updated_at = datetime('now') 
WHERE user_id = $USER_ID AND type = 'password';

-- Se não existia, inserir
INSERT INTO auth (user_id, secret, type, created_at, updated_at)
SELECT $USER_ID, '$HASH', 'password', datetime('now'), datetime('now')
WHERE (SELECT changes() = 0);

-- Mostrar registro após atualização
SELECT 'AUTH DEPOIS:' FROM auth WHERE user_id = $USER_ID AND type = 'password';

-- Mostrar resultado final
SELECT 'RESULTADO: Senha atualizada para usuário ID: $USER_ID';
SELECT 'NOVO HASH: ' || (SELECT secret FROM auth WHERE user_id = $USER_ID AND type = 'password');
EOF
    
    # Mostrar SQL
    print_info "Comandos SQL a serem executados:"
    cat $TMP_SQL
    
    echo
    read -p "Deseja continuar com a execução? (s/N): " CONFIRM
    if [[ ! "$CONFIRM" =~ ^[Ss]$ ]]; then
        print_info "Operação cancelada"
        rm $TMP_SQL
        return 1
    fi
    
    # Executar
    SQL_OUTPUT=$(cat $TMP_SQL | docker exec -i $CONTAINER_NAME sqlite3 /data/database.sqlite 2>&1)
    SQL_EXIT_CODE=$?
    
    echo -e "${YELLOW}Saída do SQLite:${NC}"
    echo "$SQL_OUTPUT"
    
    if [ $SQL_EXIT_CODE -ne 0 ]; then
        print_error "Erro ao executar SQL (código: $SQL_EXIT_CODE)"
        rm $TMP_SQL
        return 1
    fi
    
    rm $TMP_SQL
    
    # Verificar se a senha foi atualizada
    AUTH_CHECK=$(docker exec $CONTAINER_NAME sqlite3 /data/database.sqlite "SELECT COUNT(*) FROM auth WHERE user_id = $USER_ID AND type = 'password';")
    
    if [ "$AUTH_CHECK" -gt 0 ]; then
        print_success "Senha atualizada com sucesso para usuário ID $USER_ID!"
    else
        print_error "Falha ao atualizar senha. Verifique os logs acima."
    fi
}

# Menu principal
main_menu() {
    print_header "NGINX PROXY MANAGER - RECUPERAÇÃO DE ACESSO"
    echo "1) Criar novo usuário administrador"
    echo "2) Resetar senha de usuário existente"
    echo "3) Sair"
    echo
    read -p "Escolha uma opção [1-3]: " OPTION
    
    case $OPTION in
        1)
            create_new_user
            ;;
        2)
            reset_existing_password
            ;;
        3)
            print_info "Saindo..."
            exit 0
            ;;
        *)
            print_error "Opção inválida"
            main_menu
            ;;
    esac
}

# Função principal
main() {
    print_header "SCRIPT DE RECUPERAÇÃO - NPM"
    
    check_dependencies
    list_npm_containers
    install_sqlite_in_container
    main_menu
    
    print_success "Operação concluída! Reinicie o container para garantir:"
    echo "  docker restart $CONTAINER_NAME"
}

# Executar script
main