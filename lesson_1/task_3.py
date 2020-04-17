# 3. Узнайте у пользователя число n. Найдите сумму чисел n + nn + nnn. Например, пользователь ввёл число 3. Считаем 3
# + 33 + 333 = 369.

user_number = input("Введите целое число: ")
while True:
    if user_number.isdigit():
        i = 1
        i_max = 3
        result = 0
        while i <= i_max:
            result += int(i*user_number)
            i += 1
        print(result)
        break
    else:
        user_number = input("Необходимо ввести целое число: ")
