import sys

if __name__ == "__main__":
    for line in sys.stdin:
        clave = line.split('   ')[0]
        fecha = line.split('   ')[1]
        valor = int(line.split('   ')[2])
        valor_format = "{:03.0f}".format(valor)
        sys.stdout.write("{}\t{}\t{}\t{}\n".format(valor_format,clave,fecha,valor))
