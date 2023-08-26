#!/bin/bash

clear

# Função para gerar um número aleatório entre 1 e $1
roll_dice() {
    echo $((1 + RANDOM % $1))
}

# Função para imprimir uma face do dado com o número no centro
print_dice_face() {
    local number=$1
    echo "  +-------+"
    echo "  |       |"
    echo "  |   $number   |"
    echo "  |       |"
    echo "  +-------+"
}

# Verifica se o argumento foi fornecido
if [ $# -eq 0 ]; then
    echo "Uso: $0 <valor do dado no formato 'Ndl+M'>"
    exit 1
fi

# Obtém o valor do argumento
dice_expression=$1

# Extrai o número de dados, número de lados do dado e o valor a ser subtraído
num_dice=$(echo $dice_expression | cut -d'd' -f1)
num_sides=$(echo $dice_expression | cut -d'd' -f2 | cut -d'-' -f1)
subtract=$(echo $dice_expression | cut -d'-' -f2)

# Inicializa a soma dos valores dos dados
total=0

# Simula os lançamentos dos dados e realiza a subtração
for ((i=0; i<num_dice; i++)); do
    result=$(roll_dice $num_sides)
    total=$((total + result))
    print_dice_face $result
    sleep 1
done

# Calcula o resultado final
result=$((total - subtract))

echo "Soma dos valores dos dados: $total"
echo "Resultado final (soma + modificador): $result"
