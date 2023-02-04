# Renderização de Imagens

Para a renderização de imagens isto não é diferente do utilizado para a exibição de blocos, contudo, para tornar a renderização mais coerente a seguinte equação foi adotada:
```
    Endereço_Inicial_de_Pixels = 0XFF000000 + 320 * Deslocamento_em_Linhas + Deslocamento_em_Colunas
```

Sendo que uma pequena otimização pode ser realizada para o número 320, pois:
```
    320 = 256 + 64 = 1 << 9 + 1 << 6
```

Assim:
```
    Endereço_Inicial_de_Pixels = 0XFF000000 + Deslocamento_em_Linhas << 9 + Deslocamento_em_Linhas << 6 + Deslocamento_em_Colunas
```
