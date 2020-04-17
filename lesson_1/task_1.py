# 1. Поработайте с переменными, создайте несколько, выведите на экран, запросите у пользователя несколько чисел и
# строк и сохраните в переменные, выведите на экран.
var_int = 123
var_str = 'one two three'
var_list = [1, 2, 3]
var_tuple = (1, 2, 3)
var_float = 12.3
var_dict = {1: "one", 2: "two", 3: "three"}
print(type(var_int), var_int)
print(type(var_str), var_str)
print(type(var_list), var_list)
print(type(var_tuple), var_tuple)
print(type(var_float), var_float)
print(type(var_dict), var_dict, '\n')

name = input("Enter your name: ")
surname = input("Enter your surname: ")
age = input("Enter your age: ")
city = input("Enter your current city: ")
city_living = input("How long do you live in the city: ")
print("\n", name, surname, age, "\n", city, city_living)
