import sys

if __name__ == '__main__':

    n=0
    printed = 0
    minimo = 999

    while n < 6: 

        for line in sys.stdin:
            key, val = line.split("\t")
            val = int(val)

            if printed < val < minimo:
                minimo = val
                minkey = key
        sys.stdout.write("{},{}\n".format(minkey, minimo))     
        printed = printed + 1
        n = n + 1