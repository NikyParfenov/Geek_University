# 4. Пользователь вводит целое положительное число. Найдите самую большую цифру в числе. Для решения используйте цикл
# while и арифметические операции.

user_number = input("Введите целое положительно число: ")
while True:
    if user_number.isdigit():
        # Надо было внимательнее читать задание...
        # max_num = -999
        # i = 0
        # while i < len(user_number):
        #     if max_num < int(user_number[i]):
        #         max_num = int(user_number[i])
        #     i += 1
        max_num = 0
        temp = int(user_number)
        while max_num != 9 and temp:
            if temp % 10 > max_num:
                max_num = temp % 10
            temp //= 10
        break
    else:
        user_number = input("Необходимо ввести целое положительно число: ")
print(f"Из числа {user_number} наибольшая цифра {max_num}")
