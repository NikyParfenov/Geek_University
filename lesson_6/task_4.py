# 4. Реализуйте базовый класс Car. У данного класса должны быть следующие атрибуты: speed, color, name, is_police (
# булево). А также методы: go, stop, turn(direction), которые должны сообщать, что машина поехала, остановилась,
# повернула (куда). Опишите несколько дочерних классов: TownCar, SportCar, WorkCar, PoliceCar. Добавьте в базовый
# класс метод show_speed, который должен показывать текущую скорость автомобиля. Для классов TownCar и WorkCar
# переопределите метод show_speed. При значении скорости свыше 60 (TownCar) и 40 (WorkCar) должно выводиться
# сообщение о превышении скорости.
# Создайте экземпляры классов, передайте значения атрибутов. Выполните доступ к
# атрибутам, выведите результат. Выполните вызов методов и также покажите результат.
from random import choice


class Car:
    car_items = []
    is_police = False

    def __init__(self, speed: int, color: str, name: str):
        self.speed = speed
        self.color = color
        self.name = name
        Car.car_items.append(self)

    def go(self):
        print('- Машина поехала')

    def stop(self):
        print('- Машина остановилась')

    def turn(self, direction='в никуда...'):
        print(f'- Машина повернула {direction}')

    def show_speed(self, speed):
        print(f'- Cкорость автомобиля {self.speed}')


class TownCar(Car):
    # конструктор можно убрать/заменить на pass, т.к. атрибуты инициализированы в родителе
    def __init__(self, speed: int, color: str, name: str):
        super().__init__(speed, color, name)

    def show_speed(self, speed):
        print(f'- Текущая скорость автомобился {speed}') if self.speed <= 60 else print('- Превышение скорости!')


class SportCar(Car):
    # конструктор можно убрать/заменить на pass, т.к. атрибуты инициализированы в родителе
    def __init__(self, speed: int, color: str, name: str):
        super().__init__(speed, color, name)


class WorkCar(Car):
    # конструктор можно убрать/заменить на pass, т.к. атрибуты инициализированы в родителе
    def __init__(self, speed: int, color: str, name: str):
        super().__init__(speed, color, name)

    def show_speed(self, speed):
        print(f'- Текущая скорость автомобился {speed}') if self.speed < 40 else print('- Превышение скорости!')


class PoliceCar(Car):
    is_police = True

    # конструктор можно убрать/заменить на pass, т.к. атрибуты инициализированы в родителе
    def __init__(self, speed: int, color: str, name: str):
        super().__init__(speed, color, name)


ford = SportCar(speed=200, color='red', name='Ford Mustang')
toyota = PoliceCar(speed=140, color='white', name='Toyota Camry')
bmw = TownCar(speed=80, color='blue', name='BMW 3 series')
gazel = WorkCar(speed=35, color='white', name='Gazel')

for sample in Car.car_items:
    print(f'{sample.name}, {sample.color}, {sample.speed} km/h, Police: {sample.is_police}')
    sample.go()
    sample.stop()
    sample.turn(choice(['налево', 'направо']))
    sample.show_speed(sample.speed)
