import sys

if __name__ == '__main__':

    for line in sys.stdin:
        val, key, val2 = line.split("\t")
        val2=int(val2)

        sys.stdout.write("{},{}\n".format(key, val2))
