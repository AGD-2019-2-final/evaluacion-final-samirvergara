import sys

if __name__ == '__main__':
        n=0
        for line in sys.stdin:
            orden, key, fecha, val = line.split("\t")
            val=int(val)

            if n < 6:
                sys.stdout.write("{}   {}   {}\n".format(key, fecha, val))
            n = n + 1
