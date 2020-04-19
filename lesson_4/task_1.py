# 1. Реализовать скрипт, в котором должна быть предусмотрена функция расчета заработной платы сотрудника. В расчете
# необходимо использовать формулу: (выработка в часах * ставка в час) + премия. Для выполнения расчета для конкретных
# значений необходимо запускать скрипт с параметрами.
import sys


def salary_count(script_name, work_time, salary_rate, reward):
    total_salary = (work_time * salary_rate) + reward
    return total_salary


_, work_time, salary_rate, reward = sys.argv
print(f'Зарплата сотрудника: {salary_count(_, float(work_time), float(salary_rate), float(reward))}')
