import sys

if __name__ == "__main__":
    for line in sys.stdin:
        numero = int(line.split('\t')[0])
        numero_format = "{:03.0f}".format(numero)

        letras = line.split('\t')[1]
        letras = letras.rstrip('\r\n')
        letras_sep = letras.split(',')

        for i in range(len(letras)):
            sys.stdout.write("{}\t{}\n".format(str(letras[i]),numero_format))