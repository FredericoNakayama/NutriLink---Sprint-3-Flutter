import '../models/content_article.dart';

/// Conteúdos educativos mockados do espaço "Conteúdos" do NutriLink.
class MockContents {
  MockContents._();

  static const List<ContentArticle> all = [
    ContentArticle(
      id: 'extracao-manual',
      category: ContentCategory.extracao,
      title: 'Técnica de Extração Manual',
      summary:
          'Aprenda o passo a passo para extrair o leite com as mãos de forma '
          'segura, confortável e eficiente.',
      readTime: '4 min de leitura',
      sections: [
        ContentSection(
          heading: 'Preparação',
          body:
              'Higienize as mãos com água e sabão por 20 segundos e escolha um '
              'ambiente calmo. Ter uma foto do bebê por perto ajuda a estimular '
              'a descida do leite.',
        ),
        ContentSection(
          heading: 'A pega em "C"',
          body:
              'Posicione o polegar e o indicador formando a letra C, cerca de 3 '
              'cm atrás do mamilo. Pressione em direção ao tórax e depois '
              'comprima suavemente em ritmo constante.',
        ),
        ContentSection(
          heading: 'Ritmo e rodízio',
          body:
              'Repita o movimento de forma rítmica, sem deslizar os dedos sobre '
              'a pele. Vá girando a posição dos dedos ao redor da aréola para '
              'esvaziar todas as áreas da mama.',
        ),
      ],
    ),
    ContentArticle(
      id: 'armazenamento-seguro',
      category: ContentCategory.armazenamento,
      title: 'Armazenamento Seguro do Leite',
      summary:
          'Saiba por quanto tempo e como conservar o leite materno extraído '
          'preservando todas as suas propriedades.',
      readTime: '3 min de leitura',
      sections: [
        ContentSection(
          heading: 'Frasco correto',
          body:
              'Use frasco de vidro com tampa plástica, previamente fervido por '
              '15 minutos. Etiquete sempre com a data e a hora da extração.',
        ),
        ContentSection(
          heading: 'Tempo de conservação',
          body:
              'Geladeira: até 12 horas. Freezer ou congelador: até 15 dias. '
              'Nunca reaqueça o leite no micro-ondas nem o ferva — isso destrói '
              'nutrientes e anticorpos.',
        ),
        ContentSection(
          heading: 'Descongelamento',
          body:
              'Descongele em banho-maria com o fogo desligado. Após descongelado, '
              'use em até 24 horas e nunca recongele.',
        ),
      ],
    ),
    ContentArticle(
      id: 'pega-correta',
      category: ContentCategory.amamentacao,
      title: 'Pega Correta do Bebê',
      summary:
          'Uma boa pega evita fissuras e garante que o bebê mame de forma '
          'eficaz. Veja os sinais de que está tudo certo.',
      readTime: '5 min de leitura',
      sections: [
        ContentSection(
          heading: 'O que observar',
          body:
              'A boca do bebê deve abocanhar boa parte da aréola, não apenas o '
              'mamilo. O queixo encosta na mama e os lábios ficam virados para '
              'fora, como um peixinho.',
        ),
        ContentSection(
          heading: 'Sinais de pega eficaz',
          body:
              'Você ouve o bebê engolindo, sente sucção sem dor e as mamas ficam '
              'mais macias após a mamada. Dor intensa é sinal de que a pega '
              'precisa ser corrigida.',
        ),
      ],
    ),
    ContentArticle(
      id: 'aumentar-producao',
      category: ContentCategory.amamentacao,
      title: 'Como Aumentar a Produção de Leite',
      summary:
          'A produção funciona por oferta e demanda. Conheça hábitos que '
          'ajudam a manter e aumentar a quantidade de leite.',
      readTime: '4 min de leitura',
      sections: [
        ContentSection(
          heading: 'Oferta e demanda',
          body:
              'Quanto mais o peito é esvaziado, mais leite o corpo produz. '
              'Ofereça o peito com frequência e faça a extração regularmente.',
        ),
        ContentSection(
          heading: 'Cuide de você',
          body:
              'Mantenha-se bem hidratada, tenha uma alimentação equilibrada, '
              'descanse quando o bebê dormir e evite o estresse sempre que '
              'possível. O bem-estar da mãe reflete na produção.',
        ),
      ],
    ),
    ContentArticle(
      id: 'higiene-extracao',
      category: ContentCategory.extracao,
      title: 'Higiene na Extração',
      summary:
          'Cuidados de higiene simples que garantem a segurança do leite '
          'doado do início ao fim do processo.',
      readTime: '3 min de leitura',
      sections: [
        ContentSection(
          heading: 'Antes de começar',
          body:
              'Lave bem as mãos e os antebraços, prenda os cabelos e utilize '
              'uma máscara ou um pano limpo sobre o nariz e a boca para não '
              'contaminar o leite ao falar.',
        ),
        ContentSection(
          heading: 'Utensílios',
          body:
              'Esterilize frascos e as peças da bomba a cada uso. Limpe as mamas '
              'apenas com água — não é necessário sabão a cada extração.',
        ),
      ],
    ),
    ContentArticle(
      id: 'quem-pode-doar',
      category: ContentCategory.doacao,
      title: 'Quem Pode Ser Doadora',
      summary:
          'Descubra os critérios para se tornar uma doadora de leite humano '
          'e como funciona a triagem.',
      readTime: '2 min de leitura',
      sections: [
        ContentSection(
          heading: 'Critérios básicos',
          body:
              'Podem doar mães saudáveis, que estejam amamentando e tenham '
              'excesso de produção de leite. O processo de triagem é gratuito e '
              'inclui uma avaliação clínica simples.',
        ),
        ContentSection(
          heading: 'Doação sem medo',
          body:
              'Doar não reduz o leite do seu próprio bebê. A doação é sempre '
              'voluntária e pode ser encerrada a qualquer momento, sem '
              'nenhuma obrigação.',
        ),
      ],
    ),
  ];
}
