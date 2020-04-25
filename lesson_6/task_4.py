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

    def __init__(self, speed: int, color: str, name: str, is_police: bool):
        self.speed = speed
        self.color = color
        self.name = name
        self.is_police = is_police
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
    def __init__(self, speed: int, color: str, name: str, is_police: bool):
        super().__init__(speed, color, name, is_police)

    def show_speed(self, speed):
        print(f'- Текущая скорость автомобился {speed}') if self.speed <= 60 else print('- Превышение скорости!')


class SportCar(Car):
    def __init__(self, speed: int, color: str, name: str, is_police: bool):
        super().__init__(speed, color, name, is_police)


class WorkCar(Car):
    def __init__(self, speed: int, color: str, name: str, is_police: bool):
        super().__init__(speed, color, name, is_police)

    def show_speed(self, speed):
        print(f'- Текущая скорость автомобился {speed}') if self.speed < 40 else print('- Превышение скорости!')


class PoliceCar(Car):
    def __init__(self, speed: int, color: str, name: str, is_police: bool):
        super().__init__(speed, color, name, is_police)


ford = SportCar(speed=200, color='red', name='Ford Mustang', is_police=False)
toyota = PoliceCar(speed=140, color='white', name='Toyota Camry', is_police=True)
bmw = TownCar(speed=80, color='blue', name='BMW 3 series', is_police=False)
gazel = WorkCar(speed=35, color='white', name='Gazel', is_police=False)

for sample in Car.car_items:
    print(f'{sample.name}, {sample.color}, {sample.speed} km/h, Police: {sample.is_police}')
    sample.go()
    sample.stop()
    sample.turn(choice(['налево', 'направо']))
    sample.show_speed(sample.speed)
