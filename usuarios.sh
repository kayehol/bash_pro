#!/bin/bash
# usuarios.sh
#
# Mostra login e nomes de usuários do sistema
# Lê dados do arquivo /etc/passwd
#
# Versão 1: Mostra usuários e nomes separados por TAB
# Versão 2: Adicionado suporte a opção -h
# Versão 3: Adicionado suporte a opção -V e opções inválidas
# Versão 4: Arrumado bug quando não tem opções, basename no
#           nome do programa, -V extraindo direto dos cabeçalhos,
#           adicionadas opções --help e --version
# Versão 5: Adicionadas opções -s e --sort
# Versão 6: Adicionadas opções -r, --reverse, -u, --uppercase,
#           leitura de múltiplas opções
# Versão 7: Melhorias no código para que fique mais legível,
#           adicionadas opções -d e --delimiter
#
# Kayê, abril de 2024
  #

MENSAGEM_USO="
Uso: $(basename "$0") OPÇÔES

OPÇÔES:
-d, --delimiter C Usa o caractere C como delimitador
-r, --reverse     Inverte a listagem
-s, --sort        Orderna a listagem alfabeticamente
-u, --uppercase   Mostra a listagem em MAIÚSCULAS

-h, --help        Mostra esta tela de ajuda e sai
-V, --version     Mostra a versão do programa e sai
"
ordenar=0
inverter=0
maiuscula=0
delim='\t'

while test -n "$1"
do
  case "$1" in
    -h | --help)
      echo "$MENSAGEM_USO"
      exit 0
    ;;

    -V | --version)
      echo -n $(basename "$0") 
      grep '^# Versão ' "$0" | tail -1 | cut -d : -f 1 | tr -d \#
      exit 0
    ;;

    -s | --sort) ordenar=1 ;;

    -r | --reverse) inverter=1 ;;

    -u | --upercase) maiuscula=1 ;;

    -d | --delimiter) 
      shift
      delim="$1" 

      if test -z "$delim"
      then
        echo "Faltou o argumento para a -d"
        exit 1
      fi 
    ;;

    *)
      echo Opção inválida: $1
      exit 1
    ;;
  esac

  shift
done

lista=$(cut -d : -f 1,5 /etc/passwd)

test "$ordenar" = 1 && lista=$(echo "$lista" | sort)

test "$inverter" = 1 && lista=$(echo "$lista" | tac)

test "$maiuscula" = 1 && lista=$(echo "$lista" | tr a-z A-Z)

echo "$lista" | tr : "$delim"

