# 2. Пользователь вводит время в секундах. Переведите время в часы, минуты и секунды и выведите в формате чч:мм:сс.
# Используйте форматирование строк.

user_seconds = input('Введите колчиство секунд: ')
while True:
    if user_seconds.isdigit():
        user_seconds = int(user_seconds)
        break
    else:
        user_seconds = input('Необходимо ввести целое положительное число: ')

seconds = user_seconds % 60
minutes = user_seconds // 60 % 60
hours = user_seconds // 3600
print(f'\nВремя (в формате hh:mm:ss): {hours}:{minutes}:{seconds}')
print("Внимание! Количество часов превышает 1 сутки!") if hours > 24 else None
