# 4. Пользователь вводит целое положительное число. Найдите самую большую цифру в числе. Для решения используйте цикл
# while и арифметические операции.

user_number = input("Введите целое положительно число: ")
while True:
    if user_number.isdigit():
        max_num = -999
        i = 0
        while i < len(user_number):
            if max_num < int(user_number[i]):
                max_num = int(user_number[i])
            i += 1
        break
    else:
        user_number = input("Необходимо ввести целое положительно число: ")
print(f"Из числа {user_number} наибольшая цифра {max_num}")
