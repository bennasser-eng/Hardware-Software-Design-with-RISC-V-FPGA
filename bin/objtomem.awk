# On utilise désormais objdump -s pour se faciliter la vie
# Contenu de la section .text :
#  1000 930f0000 930f7000 930fc0ff 93004000  ......p.......@.
#  1010 938f0000 938f3000 938fd0ff 1301c0ff  ......0.........
#  1020 930f3100 930fd1ff 9301f07f 938f1100  ..1.............
#  1030 13020080 930ff2ff 13030001 930f0301  ................
#  1040 930300ff 938f03ff 37040080 1304f4ff  ........7.......
#  1050 930f1400 9304f0ff 938f1400 938f2403  ..............$.
#  1060 eff05ffa                             .._.            
# Contenu de la section .data :
#  1064 78563412 cacaefbe adde0000 00000000  xV4.............
#  1074 00000000 0000                        ......

function swapbytes(drow) {
    return substr(drow, 7, 2) substr(drow, 5, 2) substr(drow, 3, 2) substr(drow, 1, 2)
}

function writemem(addr, section) {
    printf("@%08x\n", addr) # Adresse formatée
    # On a aligné sur un multiple de 8, let's go
    for (i = 1; i < length(section); i += 8) {
        print(substr(section, i, 8));
    }
    print "FFFFFFFF" # Balise de fin de section (constante)
}

# Ligne donnant l'info de la section
# Toujours trouvée avant le reste
/^Contenu|^Contents/ {
    if (content) {
        writemem(start_addr, content)
    }
    # En toute logique on pourrait mettre là le nom de section, mais
    # ça dépend de la locale, donc pour l'instant on laisse tomber
    section = 1
    content = ""
}

/^\s*[0-9a-f]+/ {
    if (section) {
        addr = strtonum("0x" $1)
        start_addr = strtonum("0x" $1) / 4
        if (addr != start_addr * 4) {
            print("Début de section non alignée : "addr) > "/dev/stderr"
            exit
        }
        section = 0;
    }

    for (i = 2; i <= NR; i++) {
        v = $i
        if (v ~ /[0-9a-f]{2,8}/) {
            # Le dernier nombre peut avoir une taille 2, 4, 6, 8
            if (length(v) == 6) {
                v = v "00"
            } else if (length($i) == 4) {
                v = v "0000"
            } else if (length($i) == 2) {
                v = v "000000"
            } else if (length($i) != 8) {
                # Pour la partie avec les '.'
                continue;
            }
            content = content swapbytes(v)
        }
    }
}

END {
    if (content) {
        writemem(start_addr, content)
    }
}
