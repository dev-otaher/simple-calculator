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
    array=("$@")
    array_length="${#array[@]}"
    a="${array[0]}"
    op="${array[1]}"
    b="${array[2]}"
    if [ "$array_length" -eq 3 ] &&
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

history='operation_history.txt'
welcome='Welcome to the basic calculator!'
guide="Enter an arithmetic operation or type 'quit' to quit:"
farewell='Goodbye!'

rm "$history"
echo "$welcome" | tee -a "$history"
while true; do
    echo "$guide" | tee -a "$history"
    read -ra input
    echo "${input[@]}" >> "$history"

    if [ "${#input[@]}" -eq 1 ] && [ "${input[0]}" == 'quit' ]; then
        echo "${farewell}" | tee -a "$history"
        break;
    fi

    if [ "$(is_valid_equation "${input[@]}")" -eq 1 ]; then
        calculate_equaltion "${input[@]}" | tee -a "$history" 
    else
        echo 'Operation check failed!' | tee -a "$history"
    fi
done
