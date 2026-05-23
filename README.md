::: titlepage
[image]{.image .placeholder original-image-src="Symbolfumg.jpg"
original-image-title="" width="35%"}\
[Universidade Federal de Minas Gerais]{.smallcaps}\
[Introdução a Sistemas Lógicos]{.smallcaps}\
[]{.smallcaps}\

------------------------------------------------------------------------

\
**Detector de Números Primos de 4 bits**\

------------------------------------------------------------------------

\
*Autor:*\
Rodrigo de Freitas Lanaza\
Matrícula: 2025051446\
2026-05-23\
:::

# Introdução

Em sistemas digitais, é frequente a necessidade de identificar
propriedades específicas de valores numéricos representados em formato
binário. Um exemplo clássico desta aplicação é a identificação de
números primos, definidos como números inteiros maiores que 1 que são
divisíveis apenas por 1 e por si mesmos.

O objetivo deste trabalho prático é projetar e implementar um circuito
lógico combinacional capaz de detetar se um dado número binário de 4
bits representa um número primo. A implementação deve ser realizada
utilizando a linguagem de descrição de hardware Verilog, adotando um
estilo de modelação estrutural.

O circuito projetado recebe como entrada um valor binário de 4 bits
($N[3:0]$), o que possibilita representar valores decimais num intervalo
de 0 a 15. A saída do circuito consiste num único bit ($P$), tal que
$P=1$ indica que a entrada corresponde a um número primo, e $P=0$ indica
que o número não é primo. Dentro do limite de 4 bits, os valores que
ativam a saída do sistema são: 2, 3, 5, 7, 11 e 13.

# Decisões de Implementação do Circuito

Para montar o circuito que detecta números primos, seguindo as
definições do trabalho, montei um circuito combinacional e utilizei
Verilog no estilo estrutural. Não foi utilizado descrições
comportamentais completas, `if` e `always`). O código Verilog e o
diagrama lógico foi construído apenas conectando portas lógicas básicas
**AND**, **OR** e **NOT**. Para que o circuito ficasse o menor possível,
simplifiquei a função usando o Mapa de Karnaugh usando **Pos**, Product
of Sums.

Utilizei em todas as portas lógicas, portas com duas entradas apenas.
Por causa dessa limitação, quando a equação exigia somar três variáveis
ao mesmo tempo, liguei duas portas OR em sequência. Já para a
multiplicação final de todos os termos, organizei as portas AND,
juntando os sinais aos poucos, de dois em dois, até chegar ao resultado
final de forma limpa e organizada.

# Tabela Verdade

A Tabela verdade abaixo apresenta a especificação completa do
comportamento esperado para o circuito combinacional. A função de saída
($P$) assume o valor lógico de 1 exclusivamente para as entradas cujo
valor decimal seja um número primo.

   **Decimal**   **Binário ($N[3:0]$)**   **Saída ($P$)**
  ------------- ------------------------ -----------------
        0                 0000                   0
        1                 0001                   0
        2                 0010                   1
        3                 0011                   1
        4                 0100                   0
        5                 0101                   1
        6                 0110                   0
        7                 0111                   1
        8                 1000                   0
        9                 1001                   0
       10                 1010                   0
       11                 1011                   1
       12                 1100                   0
       13                 1101                   1
       14                 1110                   0
       15                 1111                   0

# Forma Canônica

A forma canônica descreve a função lógica diretamente a partir da tabela
verdade. Pode ser expressa como a Soma de Mintermos (focando nas linhas
onde a saída é 1) ou como o Produto de Maxtermos (focando nas linhas
onde a saída é 0).

Considerando o vetor de entrada $N[3:0]$ com as variáveis
$N_3, N_2, N_1$ e $N_0$ (sendo $N_3$ o bit mais significativo), sabemos
que a saída $P=1$ para os seguintes valores decimais: 2, 3, 5, 7, 11 e
13.

## Soma de Mintermos

Utilizando a notação padrão para a soma de mintermos, a função lógica do
circuito é definida por:
$$P(N_3, N_2, N_1, N_0) = \sum m(2, 3, 5, 7, 11, 13)$$

A expressão booleana expandida (Soma de Produtos) correspondente a estes
mintermos é escrita como:
$$P = (\overline{N_3}\overline{N_2}N_1\overline{N_0}) + (\overline{N_3}\overline{N_2}N_1N_0) + (\overline{N_3}N_2\overline{N_1}N_0) + (\overline{N_3}N_2N_1N_0) + (N_3\overline{N_2}N_1N_0) + (N_3N_2\overline{N_1}N_0)$$

## Produto de Maxtermos

Em contrapartida, avaliando os casos onde a saída não representa um
número primo ($P=0$), obtemos a notação em produto de maxtermos:
$$P(N_3, N_2, N_1, N_0) = \prod M(0, 1, 4, 6, 8, 9, 10, 12, 14, 15)$$

A expressão booleana expandida (Produto de Somas) correspondente a estes
mintermos é escrita como: $$\begin{align*}
P &= (N_3 + N_2 + N_1 + N_0) \cdot (N_3 + N_2 + N_1 + \overline{N_0}) \\
  &\quad \cdot (N_3 + \overline{N_2} + N_1 + N_0) \cdot (N_3 + \overline{N_2} + \overline{N_1} + N_0) \\
  &\quad \cdot (\overline{N_3} + N_2 + N_1 + N_0) \cdot (\overline{N_3} + N_2 + N_1 + \overline{N_0}) \\
  &\quad \cdot (\overline{N_3} + N_2 + \overline{N_1} + N_0) \cdot (\overline{N_3} + \overline{N_2} + N_1 + N_0) \\
  &\quad \cdot (\overline{N_3} + \overline{N_2} + \overline{N_1} + N_0) \cdot (\overline{N_3} + \overline{N_2} + \overline{N_1} + \overline{N_0})
\end{align*}$$

# Mapa de Karnaugh

Para obter a forma simplificada em Produto de Somas (PoS), mapeamos os
maxtermos da função, que correspondem às combinações binárias cuja saída
é $0$ (números não primos).

Abaixo estão apresentados os dois Mapas de Karnaugh estruturados de
forma quadrada com a contagem disposta estritamente na vertical (de cima
para baixo). O primeiro mapa exibe os valores puros do circuito e o
segundo ilustra os laços dos agrupamentos. Os números menores em cinza
indicam o valor decimal equivalente de cada célula.

## 4.1. Mapa de Karnaugh

<figure data-latex-placement="H">

</figure>

## 4.2. Mapa de Karnaugh (Primos Essenciais)

<figure data-latex-placement="H">

</figure>

# Minimização

A partir da análise dos agrupamentos máximos de zeros isolados no mapa
anterior, podemos classificar e mapear os termos simplificados.

## Classificação dos Implicantes

- **Implicantes Primos Encontrados:** (0,1,8,9), (4,6,12,14),
  (8,10,12,14), (14,15) e (0,4,8,12).

- **Implicantes Primos Essenciais:** Aqueles que cobrem elementos de
  forma única e exclusiva. São os responsáveis por compor a resposta
  final.

  - [**Laço Vermelho (0, 1, 8, 9):**]{style="color: red"} Essencial para
    cobrir exclusivamente os zeros das células 1 e 9. Termo:
    $(N_2 + N_1)$

  - [**Laço Verde (4, 6, 12, 14):**]{style="color: darkgreen"} Essencial
    para cobrir exclusivamente o zero da célula 6. Termo:
    $(\overline{N_2} + N_0)$

  - [**Laço Azul (8, 10, 12, 14):**]{style="color: blue"} Essencial para
    cobrir exclusivamente o zero da célula 10. Termo:
    $(\overline{N_3} + N_0)$

  - [**Laço Laranja (14, 15):**]{style="color: orange"} Essencial para
    cobrir exclusivamente o zero da célula 15. Termo:
    $(\overline{N_3} + \overline{N_2} + \overline{N_1})$

- **Implicantes Primos Não Essenciais:** O grupo formado pelas células
  (0, 4, 8, 12) é considerado não essencial, uma vez que todos os seus
  zeros já foram completamente absorvidos e cobertos pelos demais grupos
  essenciais. Por esse motivo, ele foi descartado e não aparece
  desenhado no mapa.

## Função Minimizada (Produto de Somas - PoS)

Realizando a operação distributiva AND sobre os termos extraídos
unicamente dos grupos essenciais, chegamos à expressão final
simplificada para o circuito:

$$P(N_3, N_2, N_1, N_0) = (N_2 + N_1) \cdot (\overline{N_2} + N_0) \cdot (\overline{N_3} + N_0) \cdot (\overline{N_3} + \overline{N_2} + \overline{N_1})$$

# Diagrama Lógico do Circuito

O diagrama lógico a seguir representa a implementação estrutural do
circuito combinacional, projetado diretamente a partir da nossa equação
minimizada em Produto de Somas (PoS):
$$P(N_3, N_2, N_1, N_0) = (N_2 + N_1) \cdot (\overline{N_2} + N_0) \cdot (\overline{N_3} + N_0) \cdot (\overline{N_3} + \overline{N_2} + \overline{N_1})$$

Este circuito foi desenhado utilizando portas **AND**, **OR** e **NOT**
Para o termo da soma com 3 variáveis, duas portas **OR** foram ligadas
em cascata. Para o produto final dos 4 termos, foi utilizado três portas
**AND** de 2 entradas. Entradas negadas foram feitas com 3 portas
**NOT**, uma em cada entrada.

<figure data-latex-placement="H">
<div class="circuitikz">
<p>(or1) at (3, 4) ; (or2) at (3, 1) ; (or3) at (3, -2) ;</p>
<p>(or4a) at (1, -5) ; (or4b) at (3, -6.5) ;</p>
<p>(and1) at (6, 2.5) ; (and2) at (6, -4.25) ; (and3) at (9, -0.875)
;</p>
<p>(not_n2_or2) at (-1, 1.5) ; (not_n3_or3) at (-1, -1.5) ;
(not_n3_or4a) at (-1, -4.5) ; (not_n2_or4a) at (-1, -5.5) ;
(not_n1_or4b) at (-1, -7.0) ;</p>
<p>(-3, 4.5) node[left] <span><span
class="math inline"><em>N</em><sub>2</sub></span></span> – (-1, 4.5) |-
(or1.in 1); (-3, 3.5) node[left] <span><span
class="math inline"><em>N</em><sub>1</sub></span></span> – (-1, 3.5) |-
(or1.in 2);</p>
<p>(-3, 1.5) node[left] <span><span
class="math inline"><em>N</em><sub>2</sub></span></span> –
(not_n2_or2.in); (not_n2_or2.out) |- (or2.in 1); (-3, 0.5) node[left]
<span><span class="math inline"><em>N</em><sub>0</sub></span></span> –
(-1, 0.5) |- (or2.in 2);</p>
<p>(-3, -1.5) node[left] <span><span
class="math inline"><em>N</em><sub>3</sub></span></span> –
(not_n3_or3.in); (not_n3_or3.out) |- (or3.in 1); (-3, -2.5) node[left]
<span><span class="math inline"><em>N</em><sub>0</sub></span></span> –
(-1, -2.5) |- (or3.in 2);</p>
<p>(-3, -4.5) node[left] <span><span
class="math inline"><em>N</em><sub>3</sub></span></span> –
(not_n3_or4a.in); (not_n3_or4a.out) |- (or4a.in 1); (-3, -5.5)
node[left] <span><span
class="math inline"><em>N</em><sub>2</sub></span></span> –
(not_n2_or4a.in); (not_n2_or4a.out) |- (or4a.in 2);</p>
<p>(or4a.out) – (1.5, -5) |- (or4b.in 1);</p>
<p>(-3, -7.0) node[left] <span><span
class="math inline"><em>N</em><sub>1</sub></span></span> –
(not_n1_or4b.in); (not_n1_or4b.out) |- (or4b.in 2);</p>
<p>(or1.out) – (4.2, 4) |- (and1.in 1); (or2.out) – (4.2, 1) |- (and1.in
2); (or3.out) – (4.2, -2) |- (and2.in 1); (or4b.out) – (4.2, -6.5) |-
(and2.in 2);</p>
<p>(and1.out) – (7.2, 2.5) |- (and3.in 1); (and2.out) – (7.2, -4.25) |-
(and3.in 2);</p>
<p>(and3.out) – ++(1,0) node[right] <span><strong><span
class="math inline"><em>P</em></span></strong></span>;</p>
</div>
</figure>

# Códigos Fonte em Verilog

Abaixo estão apresentados os códigos desenvolvidos em Verilog
estrutural. O primeiro bloco exibe a implementação do circuito lógico e
o segundo bloco exibe o ambiente de testes (testbench) utilizado para a
validação.

## 7.1. Circuito Principal (`design.sv`)

    module prime_detector(
        input wire [3:0] N,
        output wire P
    );

        wire not_n3, not_n2, not_n1;
        wire or1_out, or2_out, or3_out, or4_out, or5_out;
        wire and1_out, and2_out;

        not inv_n3 (not_n3, N[3]);
        not inv_n2 (not_n2, N[2]);
        not inv_n1 (not_n1, N[1]);

        or soma1 (or1_out, N[2], N[1]);
        or soma2 (or2_out, not_n2, N[0]);
        or soma3 (or3_out, not_n3, N[0]);
        or soma4 (or4_out, not_n3, not_n2);
        or soma5 (or5_out, or4_out, not_n1);

        and mult1 (and1_out, or1_out, or2_out);
        and mult2 (and2_out, or3_out, or5_out);
        and mult3 (P, and1_out, and2_out);

    endmodule

## 7.2. Ambiente de Simulação (`testbench.sv`)

    module prime_detector_testbench;

        reg [3:0] N_testbench;
        wire P_testbench;
        integer i;

        prime_detector_testbench prime_detector (.N(N_testbench), .P(P_testbench));

        initial begin
            $dumpfile("dump.vcd");
            $dumpvars(1, prime_detector_testbench);

            $display("-------------------------------------------------------");
            $display(" time (ns) |      input       | Decimal  | Prime?");
            $display("-------------------------------------------------------");
            $monitor("   %4d     |       %4b        |   %2d    |      %b", 
                        $time, N_testbench, N_testbench, P_testbench);

            for (i = 0; i < 16; i = i + 1) begin
                N_testbench = i;
                #10;
            end

            #10;

            $finish;
        end

    endmodule

# Formas de Onda do Testbench

Para validar o funcionamento do circuito projetado, foi gerado o gráfico
de formas de onda (waveforms). O gráfico mostra a variação do sinal de
saída (`P_testbench`) e as entradas de todos os valores binários
possíveis (de 0 a 15) no barramento de entrada (`N_testbench`).

Nota-se que a saída é verdadeira perfeitamente em sincronia com as
entradas equivalentes aos números primos (2, 3, 5, 7, 11 e 13).

<figure data-latex-placement="H">
<span class="image placeholder"
data-original-image-src="Captura de Tela 2026-05-22 às 22.50.13.png"
data-original-image-title="" width="\textwidth"></span>
</figure>
