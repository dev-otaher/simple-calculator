#!/usr/bin/env bash

is_number() {
    re='^-?[0-9]+\.?[0-9]*$'
    if [[ "$1" =~ $re ]]; then
        echo 1
    else
        echo 0
    fi
}

is_operator() {
    re='^[+-\*/\^]$'
    if [[ "$1" =~ $re ]]; then
        echo 1
    else
        echo 0
    fi
}

is_valid_equation() {
    input=("$@")
    input_length="${#input[@]}"
    a="${input[0]}"
    op="${input[1]}"
    b="${input[2]}"
    if [ "$input_length" -eq 3 ] &&
        [ "$(is_number "$a")" -eq 1 ] && 
        [ "$(is_operator "$op")" -eq 1 ] && 
        [ "$(is_number "$b")" -eq 1 ]; then
        echo 1
    else
        echo 0
    fi
}

calculate_equaltion() {
    echo "scale=2;" "${input[@]}" | bc -l
}

printf 'Enter an arithmetic operation:\n'
read -ra input

if [ "$(is_valid_equation "${input[@]}")" -eq 1 ]; then
    printf "%s\n" "$(calculate_equaltion "${input[@]}")"
else
    printf 'Operation check failed!\n'
fi
