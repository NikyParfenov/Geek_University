# 1. Создать класс TrafficLight (светофор) и определить у него один атрибут color (цвет) и метод running (запуск).
# Атрибут реализовать как приватный. В рамках метода реализовать переключение светофора в режимы: красный, желтый,
# зеленый. Продолжительность первого состояния (красный) составляет 7 секунд, второго (желтый) — 2 секунды,
# третьего (зеленый) — на ваше усмотрение. Переключение между режимами должно осуществляться только в указанном
# порядке (красный, желтый, зеленый). Проверить работу примера, создав экземпляр и вызвав описанный метод. Задачу
# можно усложнить, реализовав проверку порядка режимов, и при его нарушении выводить соответствующее сообщение и
# завершать скрипт.
import time


class TrafficLight:
    __color = ''

    def running(self, chosen_color: str):
        right_order = ['red', 'yellow', 'green', 'red']
        if TrafficLight.__color and chosen_color != right_order[right_order.index(TrafficLight.__color) + 1]:
            print('Некорректный порядок включения сигналов! Отключение светофора')
            return 0
        if TrafficLight.__color == 'red':
            for i in range(7, 0, -1):
                print(i)
                time.sleep(1)
        if TrafficLight.__color == 'yellow':
            for i in range(2, 0, -1):
                print(i)
                time.sleep(1)
        if TrafficLight.__color == 'green':
            for i in range(5, 0, -1):
                print(i)
                time.sleep(1)
        TrafficLight.__color = user_color
        print(f'{TrafficLight.__color}')


road = TrafficLight()
flag = None
while flag is None:
    user_color = input('Задайте сигнал светофора red/yellow/green (любое другое для выхода): ')
    if user_color == '':
        break
    flag = road.running(user_color)
