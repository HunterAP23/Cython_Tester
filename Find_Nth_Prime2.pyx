cimport cython
import datetime as dt
import decimal
import functools as ft
import math
import numbers
import time


global table
table = []

global table2
table2 = []

global table3
table3 = []

def is_prime(int a):
    global table
    cdef int checks = 0

    if a <= 1:
        return [False, 0]
    else:
        checks = checks + 1
        for j in range(0, len(table), 1):
            checks = checks + 1
            if a % table[j] == 0:
                return [False, checks]
            else:
                continue
        table.append(a)
        return [True, checks]

def is_prime_half(int a):
    global table2
    cdef int checks = 0

    if a <= 1:
        return [False, 0]
    else:
        checks = checks + 1
        boundary = math.floor(a / 2)
        for j in range(0, len(table2), 1):
            if table2[j] <= boundary:
                checks = checks + 1
                if a % table2[j] == 0:
                    return [False, checks]
                else:
                    continue
        table2.append(a)
        return [True, checks]

def is_prime_sqrt(int a):
    global table3
    cdef int checks = 0

    if a <= 1:
        return [False, 0]
    else:
        checks = checks + 1
        boundary = int(math.floor(math.sqrt(a)))
        for j in range(0, len(table3), 1):
            if table3[j] <= boundary:
                checks = checks + 1
                if a % table3[j] == 0:
                    return [False, checks]
                else:
                    continue
        table3.append(a)
        return [True, checks]

def main(int my_max, int num_loops):
    print("Optimized started.")

    my_file = "files_runs/optimized_main_time.txt"
    my_file2 = "files_runs/optimized_main_divisions.txt"
    txt_output = open(my_file, 'a')
    txt_output2 = open(my_file2, 'a')
    time_list = []
    divisions_list = []

    for j in range(0, num_loops, 1):
        global table
        tmp_time_start = time.time()
        for i in range(my_max):
            tmp = is_prime(i)
            if tmp[0] == True:
                divisions_list.append("{0} took {1} divisions by previous primes to complete!\n\n".format(i, tmp[1]))

        tmp_time_total = time.time() - tmp_time_start

        txt_output.write("Optimized Normal Pass {0} took {1} seconds.\n".format(j + 1, tmp_time_total))
        time_list.append(tmp_time_total)
        tmp_time_total = 0
        tmp_time_start = 0
        table = []

    for item in divisions_list:
        txt_output2.write(item)

    average_time = ft.reduce(lambda a, b: a + b, time_list) / len(time_list)
    txt_output.write("The average time it took to calculate {0} optimized normal passes was {1}.".format(num_loops, average_time))
    average_time = 0
    time_list = []
    divisions_list = []
    txt_output.close()
    txt_output2.close()

    # 2nd Attempt with Half function
    my_file = "files_runs/optimized_half_time.txt"
    my_file2 = "files_runs/optimized_half_division.txt"
    txt_output = open(my_file, 'a')
    txt_output2 = open(my_file2, 'a')

    for j in range(0, num_loops, 1):
        global table2
        tmp_time_start = time.time()
        for i in range(my_max):
            tmp = is_prime_half(i)
            if tmp[0] == True:
                divisions_list.append("{0} took {1} divisions by previous primes to complete!\n\n".format(i, tmp[1]))

        tmp_time_total = time.time() - tmp_time_start

        txt_output.write("Optimized Half Pass {0} took {1} seconds.\n".format(j + 1, tmp_time_total))
        time_list.append(tmp_time_total)
        tmp_time_total = 0
        tmp_time_start = 0
        table2 = []

    for item in divisions_list:
        txt_output2.write(item)

    average_time = ft.reduce(lambda a, b: a + b, time_list) / len(time_list)
    txt_output.write("The average time it took to calculate {0} optimized half passes was {1}.".format(num_loops, average_time))
    average_time = 0
    time_list = []
    divisions_list = []
    txt_output.close()
    txt_output2.close()

    # 3rd Attempt with Sqrt function
    my_file = "files_runs/optimized_sqrt_time.txt"
    my_file2 = "files_runs/optimized_sqrt_divisions.txt"
    txt_output = open(my_file, 'a')
    txt_output2 = open(my_file2, 'a')

    for j in range(num_loops):
        global table3
        tmp_time_start = time.time()
        for i in range(my_max):
            tmp = is_prime_sqrt(i)
            if tmp[0] == True:
                divisions_list.append("{0} took {1} divisions by previous primes to complete!\n\n".format(i, tmp[1]))

        tmp_time_total = time.time() - tmp_time_start

        txt_output.write("Optimized Sqrt Pass {0} took {1} seconds.\n".format(j + 1, tmp_time_total))
        time_list.append(tmp_time_total)
        tmp_time_total = 0
        tmp_time_start = 0
        table3 = []

    for item in divisions_list:
        txt_output2.write(item)

    average_time = ft.reduce(lambda a, b: a + b, time_list) / len(time_list)
    txt_output.write("The average time it took to calculate {0} optimized square root passes was {1}.".format(num_loops, average_time))

    del average_time
    del time_list
    del divisions_list
    txt_output.close()
    txt_output2.close()

    time_now = dt.datetime.now()
    print("-"*80)
    print("Optimized Finished at {0}/{1}/{2} {3}:{4}:{5}:{6}".format(time_now.year, time_now.month, time_now.day, time_now.hour, time_now.minute, time_now.second, time_now.microsecond))
