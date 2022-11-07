# coding=utf8

# curl -s "http://www.unicode.org/Public/UNIDATA/extracted/DerivedNumericValues.txt" | grep "VULGAR FRACTION"
import re
fractions = {
    0x2189: 0.0,  # ; ; 0 # No       VULGAR FRACTION ZERO THIRDS
    0x2152: 0.1,  # ; ; 1/10 # No       VULGAR FRACTION ONE TENTH
    0x2151: 0.11111111,  # ; ; 1/9 # No       VULGAR FRACTION ONE NINTH
    0x215B: 0.125,  # ; ; 1/8 # No       VULGAR FRACTION ONE EIGHTH
    0x2150: 0.14285714,  # ; ; 1/7 # No       VULGAR FRACTION ONE SEVENTH
    0x2159: 0.16666667,  # ; ; 1/6 # No       VULGAR FRACTION ONE SIXTH
    0x2155: 0.2,  # ; ; 1/5 # No       VULGAR FRACTION ONE FIFTH
    0x00BC: 0.25,  # ; ; 1/4 # No       VULGAR FRACTION ONE QUARTER
    0x2153: 0.33333333,  # ; ; 1/3 # No       VULGAR FRACTION ONE THIRD
    0x215C: 0.375,  # ; ; 3/8 # No       VULGAR FRACTION THREE EIGHTHS
    0x2156: 0.4,  # ; ; 2/5 # No       VULGAR FRACTION TWO FIFTHS
    0x00BD: 0.5,  # ; ; 1/2 # No       VULGAR FRACTION ONE HALF
    0x2157: 0.6,  # ; ; 3/5 # No       VULGAR FRACTION THREE FIFTHS
    0x215D: 0.625,  # ; ; 5/8 # No       VULGAR FRACTION FIVE EIGHTHS
    0x2154: 0.66666667,  # ; ; 2/3 # No       VULGAR FRACTION TWO THIRDS
    0x00BE: 0.75,  # ; ; 3/4 # No       VULGAR FRACTION THREE QUARTERS
    0x2158: 0.8,  # ; ; 4/5 # No       VULGAR FRACTION FOUR FIFTHS
    0x215A: 0.83333333,  # ; ; 5/6 # No       VULGAR FRACTION FIVE SIXTHS
    0x215E: 0.875,  # ; ; 7/8 # No       VULGAR FRACTION SEVEN EIGHTHS
}

rx = r'(?u)([+-])?(\d*)(%s)' % '|'.join(map(chr, fractions))


def conv(strg):
    for sign, d, f in re.findall(rx, strg):
        sign = -1 if sign == '-' else 1
        d = int(d) if d else 0
        number = sign * (d + fractions[ord(f)])
        return str(number)


def cntnt(strg):
    """check if the string contains a number"""
    return re.search(rx, strg)


def find_max(strg):
    if '-' in strg:
        l = strg.split('-')
        # convert both to Number
        l[0] = float(l[0])
        l[1] = float(l[1])

        # return the greater of the two
        f = (max(l))
        # try to convert to int if possible
        try:
            f = int(f)
        except ValueError:
            print("ValueError")
            pass
        return str(f)
    else:
        return strg


def replace_fractions(strg):
    """Replace unicode fractions with decimal"""

    # check if it contains a unicode
    if cntnt(strg):
        # the string contains '-' split it
        if '-' in strg:
            l = strg.split('-')
            l[0] = l[0].replace(" ", "")
            l[1] = l[1].replace(" ", "")

            print(l)
            # replace the fractions
            l[0] = conv(l[0]) if cntnt(l[0]) else l[0]
            l[1] = conv(l[1]) if cntnt(l[1]) else l[1]
            print(l)

            return (l[0] + '-' + l[1])
            # # convert both to float
            # l[0] = float(l[0])
            # l[1] = float(l[1])

            # # return the greater of the two
            # return str(max(l))
        else:
            return (conv(strg))
    else:

        return (strg)


# print(replace_fractions('2-2 ½'))
