# Introdução a exibição de blocos

A princípio essa solução não deve ser aceita como a solução final, mas vou tentar explicar seu funcionamento.

Atualmente o programa do Rars possui uma tela de 320x240, sendo que cada cor de pixel exibido nessa tela utilizará 1 byte para ser exibido, sendo que neste 1 byte temos o aspecto BBGGGRRR, onde RGB, representam os canais para compor uma cor onde R = Vermelho, G = Verde, B = Azul.

Considerando os aspectos de memórias envolvido não é recomendável exibirmos toda a imagem de um mapa do jogo, porque iria consumir uma grande quantidade de memória, para evitarmos isso iremos trabalhar com tiles e sprites, onde iremos criar pequenos blocos de 16x16 pixels e então ao juntá-los será possível criar o mapa a ser exibido.

Utilizando blocos de 16x16 teremos então que o número de blocos serão (320/16)x(240/16) ou 20x15, portanto, cada mapa mostrado no jogo terá 20x15 blocos no momento em que é exibido.

## Como Funciona a exibição de bloco?

O endereço inicial da tela do Rars fica em 0xFF000000, neste endereço fica o primeiro pixel e em ```0XFF000000 + 1``` teremos o segundo e assim por diante. Logo, temos que a nova linha de pixels fica em ```0XFF000000 + 320```, e a próxima em ```0XFF000000 + 2 * 320```, ..., ```0XFF000000 + linha * 320``` caso queiramos exibir um bloco de dimensões ```largura(l) x altura(a)``` em uma posição ```(i,j)``` onde ```i = linha do bloco``` e ```j = coluna do bloco```, então o seu pixel inicial será em:

```
0XFF000000 + 320 * linha_atual_do_bloco + j * largura + 320 * i * altura
```

```linha_atual_do_bloco``` indica em qual das linhas do bloco exibido estamos, ou seja, como o bloco possui uma altura a, então teremos que linha_atual_do_bloco irá ter um loop onde ```linha_atual_do_bloco = 1```, ```linha_atual_do_bloco = 2```, ..., ```linha_atual_do_bloco = a```.

Caso queira ver a implementação deste algoritmo no Rars [veja aqui](https://github.com/uventura/oac-pokemon/commit/084e105225393eee9755fb119f166f19293c619b#diff-70b4420e73c383519f631737ef4cb31e83dd64c1b58fe28f7495322ad8ec779eR32), algumas otimizações foram feitas para lidar com o fato de termos 16x16 como tamanho dos blocos.

# Introdução a exibição de mapas

[TODO]