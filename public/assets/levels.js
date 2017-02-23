/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */


// Hash the array and compare the arrays!
// Key
// a = small apple .small
// A = apple
// o = small orange, .small
// O = orange
// p = small pickle, .small
// P = pickle
// () = plate open / close
// {} = fancy plate open / close
// [] = bento open close tags

var levels = [
  {
    helpTitle : "Selecciona los elementos por su tipo (type)",
    selectorName : "Type Selector",
    doThis : "Selecciona los platos (plates en inglés)",
    selector : "plate",
    syntax : "A",
    help : "Selecciona todos los elementos de tipo <strong>A</strong>. El 'type' se refiere al tipo de etiqueta, por ejemplo <tag>div</tag>, <tag>p</tag> y <tag>ul</tag> son elementos de diferente tipo.",
    examples : [
      '<strong>div</strong> selecciona todo los  elementos <tag>div</tag>.',
      '<strong>p</strong> selecciona todo los elementos <tag>p</tag>.',
      ],
    board: "()()"
  },
  {
    doThis : "Selecciona las caja 'bento' (bandejas japonesas)",
    selector : "bento",
    syntax : "A",
    helpTitle : "Selecciona los elementos por su tipo",
    selectorName : "Type Selector",
    help : "Selecciona todos los elementos de tipo <strong>A</strong>. Type o tipo se referiere al tipo de tag, así que <tag>div</tag>, <tag>p</tag> and <tag>ul</tag> son elementos de diferente tipo.",
    examples : [
      '<strong>div</strong> selecciona todo los <tag>div</tag> elementos.',
      '<strong>p</strong> selecciona todo los <tag>p</tag> elementos.',
      ],
    board: "[]()[]"
  },
  {
    doThis : "Selecciona el plato lujoso (fancy en inglés)",
    selector : "#fancy",
    selectorName: "ID Selector",
    helpTitle: "Selecciona los elementos con un ID",
    syntax: "#id",
    help : 'Selecciona el elemento con el atributo <strong>id</strong>. Tambien puedes combinar el ID selector con el Type selector.',
    examples : [
      '<strong>#cool</strong> seleccionará cualquier elemento con <strong>id="cool"</strong>',
      '<strong>ul#long</strong> seleccionará <strong>&lt;ul id="long"&gt;</strong>'
    ],
    board: "{}()[]"
  },
  {
    helpTitle: "Selecciona un elemento dentro de otro elemento",
    selectorName : "Descendant Selector",
    doThis : "Selecciona la manzana dentro del plato (manzana en inglés = apple)",
    selector : "plate apple",
    syntax: "A&nbsp;&nbsp;B",

    help : "Selecciona todos los elementos <strong>B</strong> dentro de <strong>A</strong>. Aquí <strong>B</strong> es el elemento descendiente (descendent element), es decir un elemento que esta dentro de otro elemento.",
    examples : [
      '<strong>p&nbsp;&nbsp;strong</strong> seleccionará todos los elementos <strong>&lt;strong&gt;</strong> que son descendientes de <strong>&lt;p&gt;</strong>',
      '<strong>#fancy&nbsp;&nbsp;span</strong> seleccionará cualquier <strong>&lt;span&gt;</strong> que es descendiente de cualquier elemento con <strong>id="fancy"</strong>',
    ],
    board: "[](A)A"
  },
  {
    doThis : "Selecciona el pepinillo (pickle  en inglés) que esta en el plato lujoso",
    selector : "#fancy pickle",
    helpTitle: "Combina Descendant & ID Selectors",
    syntax: "#id&nbsp;&nbsp;A",
    help : 'Puedes combinar cualquier selector con el descendant selector.',
    examples : [
      '<strong>#cool&nbsp;span</strong> seleccionará todos los elementos <strong>&lt;span&gt;</strong> que estan dentro de elementos con <strong>id="cool"</strong>'
    ],
    board: "[O]{P}(P)"
  },
  {
    doThis : "Selecciona las manzanas pequeñas",
    selector : ".small",
    selectorName: "Class Selector",
    helpTitle: "Selecciona elementos por su clase",

    syntax: ".classname",
    help : 'EL class selector selecciona todos los elementos con el atributo clase. Un elemento solo debe tener un ID, pero puede tener muchas clases.',
    examples : [
    '<strong>.neato</strong> selecciona todos los elementos con <strong>class="neato"</strong>'
    ],

    board: "Aa(a)()"
  },
  {
    doThis : "Selecciona las pequeñas naranjas",
    selector : "orange.small",
    helpTitle: "Combina el Class Selector",
    syntax: "A.className",
    help : 'Puedes combinar el class selector con otros selectores, por ejemplo con el type selector.',
    examples : [
      '<strong>ul.important</strong> seleccionará todos los elementos <strong>&lt;ul&gt;</strong> que tienen <strong>class="important"</strong>',
      '<strong>#big.wide</strong> selecciona todos los elementos <strong>id="big"</strong> que también tienen <strong>class="wide"</strong>'
    ],
    board: "Aa[o](O)(o)"
  },
  {
    doThis : "Selecciona las pequeñas naranjas que estan en los bentos",
    selector : "bento orange.small",
    syntax: "Vamos!",
    helpTitle: "Tu puedes hacerlo ...",
    help : 'Combina lo que aprendiste en los últimos niveles para solucionar este acertijo!',
    board: "A(o)[o][a][o]"
  },
  {
    doThis : "Select todos los platos y bentos",

    selector : "plate,bento",
    selectorName : "Comma Combinator",
    helpTitle: "Combina los selectores ... con comas!",
    syntax : "A, B",
    help : 'Esto seleccionará todos los <strong>A</strong> y <strong>B</strong> elementos. De esta manera tu puedes combinar cualquiera de los selectores y/o especificar más de uno.',
    examples: [
    '<strong>p, .fun</strong> seleccionará todos los elementos <tag>p</tag> y también todos los elementos con <strong>class="fun"</strong>',
    '<strong>a, p, div</strong> seleccionará todos los elementos <tag>a</tag>, <tag>p</tag> y <tag>div</tag>.'
    ],
    board: "pP(P)[P](P)Pp"
  },
  {
    doThis : "¡Selecciona todas las cosas!",
    selector : "*",
    selectorName:  "El Selector Universal (Universal Selector)",
    helpTitle: "Puedes seleccionar todo!",
    syntax : "*",
    help : '¡Puedes seleccionar todos los elementos con el selector universal! ',
    examples : [
      '<strong>p *</strong> seleccionará cada elemento dentro de todos los elementos <strong>&lt;p&gt;</strong>.'
    ],
    board: "A(o)[][O]{)"
  },
  {
    doThis : "Selecciona todo lo que esta en un plato",
    selector : "plate *",
    syntax : "A&nbsp;&nbsp;*",
    helpTitle: "Combinalo con el Universal Selector",
    help : 'Esto seleccionará todos los elementos dentro de <strong>A</strong>.',
    examples : [
      '<strong>p *</strong> seleccionará cada elemento dentro de todos los <strong>&lt;p&gt;</strong> elementos.',
      '<strong>ul.fancy *</strong> seleccionará cada elemento dentro de todos los elementos <strong>&lt;ul class="fancy"&gt;</strong>.'],
    board: "{o}(P)a(A)"
  },
  {
    doThis : "Selecciona todas las manzanas que estan junto a un plato",
    selector : "plate + apple",
    helpTitle: "selecciona un elemento que directamente sigua a otro elemento",
    selectorName: "Adjacent Sibling Selector",
    syntax : "A + B",
    help : "Selecciona todos los elementos <strong>B</strong> que directamente siguan a <strong>A</strong>. Elementos que se siguan mutuamente se les llama hermanos (siblings). Los elementos hermanos son elementos que estan al mismo nivel, o profundidad. <br/><br/>Para este nivel elementos en el HTML que tengan la misma indentación son elementos hermanos.",
    examples : [
      '<strong>p + .intro</strong> seleccionará cada elemento con <strong>class="intro"</strong> que directamente sigue a <tag>p</tag>',
      '<strong>div + a</strong> seleccionará cada <tag>a</tag> elemento que directamente sigua a <tag>div</tag>'
    ],
    board: "[a]()a()Aaa"
  },
  {
    selectorName: "General Sibling Selector",
    helpTitle: "Selecciona elementos que siguen a otro elemento (Sibling significa hermano/a en inglés!)",
    syntax: "A ~ B",
    doThis : "Selecciona cada pepinillo a la derecha del bento",
    selector : "bento ~ pickle",
    help : "Puedes seleccionar todos los hermanos de un elemento que lo siguen. Esto es como el Adjacent Selector (A + B) (Selector Adjacente) excepto que toma todos los elementos subsiguientes en vez de uno.",
    examples : [
      '<strong>A ~ B</strong> seleccionará all <strong>B</strong> que sigue a <strong>A</strong>'
    ],
    board: "P[o]pP(P)(p)"
  },
  {
    selectorName: "Child Selector",
    syntax: "A > B&nbsp;",
    doThis : "Selecciona la manzana que esta directamente en un plato",
    selector : "plate > apple",
    helpTitle: "Selecciona al hijo directo de un elemento",
    help : "Tu puedes seleccionar elementos que son hijos directos de otros elementos. Un elemento hijo es cualquier elemento que esta anidado directamente en otro elemento. <br><br>Elementos que estan anidados más profundamente se les llama elementos descendientes.",
    examples : [
      '<strong>A > B</strong> seleccionará todos los <strong>B</strong> que son hijos directos de <strong>A</strong>'
    ],
    board: "([A])(A)()Aa"
  },

  {
    selectorName: "First Child Pseudo-selector",
    helpTitle: "Selecciona al primer elemento hijo dentro de otro elemento",
    doThis : "Selecciona la naranja de encima",
    selector : "plate :first-child",
    syntax: ":first-child",

    help : "Tu puedes seleccionar el primer elemento hijo. Un elemento hijo es cualquier elemento que esta directamente anidado en otro elemento. Tu puedes combinar este pseudo-selector con otros selectores.",
    examples : [
      '<strong>:first-child</strong> selecciona todos los primeros elemento hijos.',
      '<strong>p:first-child</strong> selecciona todos los primeros elementos <strong>&lt;p&gt;</strong>.',
      '<strong>div p:first-child</strong> selecciona todos los primeros elementos hijos <strong>&lt;p&gt;</strong> que estan dentro de <strong>&lt;div&gt;</strong>.'
    ],
    board: "[]()(OOO)p"
  },
  {
    selectorName: "Only Child Pseudo-selector",
    helpTitle: "Selecciona un elemento que es el único elemento dentro de otro.",
    doThis : "Selecciona las manzanas y pepinillos en los platos",
    selector : "plate :only-child",
    syntax: ":only-child",
    help : "Tu puedes seleccionar cualquier elemento que es el único elemento dentro de otro.",
    examples : [
      '<strong>span:only-child</strong> selecciona los elementos <strong>&lt;span&gt;</strong> que sean los únicos hijos de otros elementos',
      '<strong>ul li:only-child</strong> selecciona los únicos  elementos <strong>&lt;li&gt;</strong> dentro de <strong>&lt;ul&gt;</strong>.'
    ],
    board: "(A)(p)[]P(oO)p"
  },
  {
    selectorName: "Last Child Pseudo-selector",
    helpTitle: "Selecciona el último elemento adentro de otro elemento",
    doThis : "Selecciona la manzana pequeña y el pepinillo",
    selector : ".small:last-child",
    syntax: ":last-child",
    help : "Tu puedes utilizar este selector para seleccionar un elemento el cual es el último elemento hijo dentro de otro elemento. <br><br>Pro Tip &rarr; En casos en donde solo hay un elemento, ese elemento cuenta como el primer hijo (first-child), el único hijo (only-child) y el último hijo (last-child)!",
    examples : [
      '<strong>:last-child</strong> selecciona todos los elementos últimos hijos (last-child elements).',
      '<strong>span:last-child</strong> selecciona todos los  elementos <strong>&lt;span&gt;</strong>. últimos hijos (last-child)',
      '<strong>ul li:last-child</strong> selecciona los últimos elementos <strong>&lt;li&gt;</strong> dentro de cualquier <strong>&lt;ul&gt;</strong>.'
    ],
    board: "{a)()(oO)p"
  },
  {
    selectorName: "Nth Child Pseudo-selector",
    helpTitle: "Selecciona un elemento siguiendo su orden dentro de otro elemento",
    doThis : "Selecciona el tercer plato",
    selector : ":nth-child(3)",
    syntax: ":nth-child(A)",

    help : "selecciona el <strong>nth</strong> elemento hijo o el hijo enésimo (Ex: 1ero, 3ero, 12avo etc.) en otro elemento.",
    examples : [
      '<strong>:nth-child(8)</strong>  selecciona cada elemento que sea el 8avo hijo de otro elemento.',
      '<strong>div p:nth-child(2)</strong> selecciona el segundo <strong>p</strong> en cada <strong>div</strong>',
    ],
    board: "()()(){}"
  },
  {
    selectorName: "Nth Last Child Selector (Selector del hijo enésimo)",
    helpTitle: "Selecciona un elemento siguiendo el orden en otro elemento, contando desde atrás",
    doThis : "Selecciona el 1er bento",
    selector : "bento:nth-last-child(4)",
    syntax: ":nth-last-child(A)",
    help : "selecciona los hijos desde la parte inferior del padre. Funciona como el nth-child (hijo enésimo), pero contando desde atrás!",
    examples : [
      '<strong>:nth-last-child(2)</strong> selecciona todos los hijos penúltimos.'
    ],
    board: "()[]a(OOO)[]"
  },
  {
    selectorName: "First of Type Selector",
    helpTitle: "Selecciona el primer elemento de un tipo especifico",
    doThis : "Selecciona la primera manzana",
    selector : "apple:first-of-type",
    syntax: ":first-of-type",
    help : "selecciona el primer elemento de ese tipo dentro de otro elemento.",
    examples : [
      '<strong>span:first-of-type</strong> selecciona el primer <strong>&lt;span&gt;</strong> en cualquier elemento.'
    ],
    board: "Aaaa(oO)"
  },
  {
    selectorName: "Nth of Type Selector",
    // helpTitle: "Nth of Type Selector",
    doThis: "Selecciona todos los platos pares",
    selector: "plate:nth-of-type(even)",
    syntax: ":nth-of-type(A)",
    help: "selecciona un elemento especifico basado en su tipo y orden en otro elemento o incluso instancias pares o impares de este elemento.",
    examples: [
      '<strong>div:nth-of-type(2)</strong> selecciona la segunda instancia de un div',
      '<strong>.example:nth-of-type(odd)</strong> selecciona todas las instancias impares del elemento ejemplo.'
    ],
    board: "()()()(){}()"
  },
  {
    selectorName: "Nth-of-type Selector with Formula",
    // helpTitle: "Nth-of-type Selector with formula",
    doThis: "Selecciona cada 2do plato comenzando por el 3ero",
    selector: "plate:nth-of-type(2n+3)",
    syntax: ":nth-of-type(An+B)",
    help: "El nth-of-type formula selecciona un elemento especifico, comenzando la cuenta de una instancia especifica de ese elemento.",
    examples: [
      '<strong>span:nth-of-type(6n+2)</strong> selecciona un elemento especifico de <tag>span</tag>, comenzando (e incluyendo) la segunda instancia.'
    ],
    board: "()(p)(a)()(A)()"
  },

  {
    selectorName: "Only of Type Selector",
    helpTitle: "Selecciona los elementos que son los únicos de su tipo",
    selector : "apple:only-of-type",
    syntax: ":only-of-type",
    doThis : "Selecciona la manzana en el plato del medio.",
    help : "selecciona el único elemento de su tipo dentro de otro elemento.",
    examples : [
      '<strong>p span:only-of-type</strong> selecciona un <tag>span</tag> dentro de cualquier <tag>p</tag> siempre y cuando sea el único <tag>span</tag> adentro.'
    ],
    board: "(aA)(a)(p)"
  },

  {
    selectorName: "Last of Type Selector",
    helpTitle: "Selecciona el último elemento de un tipo especifico",
    doThis : "Selecciona la segunda manzana y naranja",
    selector : ".small:last-of-type",
    syntax: ":last-of-type",
    help : "Selecciona cada último elemento de ese tipo dentro de otro elemento. Recuerda que 'type' se refiere al tipo de etiqueta, asi que <tag>p</tag> y <tag>span</tag> son de diferentes tipos. <br><br> Me pregunto si así es cómo se seleccionó el último dinosaurio antes de que se extinguiera.",
    examples : [
      '<strong>div:last-of-type</strong> selecciona el último <strong>&lt;div&gt;</strong> en cada elemento.',
      '<strong>p span:last-of-type</strong> selecciona el último <strong>&lt;span&gt;</strong> en cada <strong>&lt;p&gt;</strong>.'
    ],
    board: "ooPPaa"
  },
  {
    selectorName: "Empty Selector",
    helpTitle: "Selecciona los selectores que no tienen hijos",
    doThis : "Selecciona los bentos vacios",
    selector : "bento:empty",
    syntax: ":empty",
    help : "selecciona un elemento especifico que no tiene otros elementos adentro",
    examples : [
      '<strong>div:empty</strong> selecciona todos los elementos vacios<strong>&lt;div&gt;</strong>.'
    ],
    board: "[][p][][]"
  },
  {
    selectorName: "Negation Pseudo-class",
    helpTitle: "Selecciona todos los elementos que no coincidan con el negation selector",

    doThis : "Selecciona las manzanas grandes",
    selector : "apple:not(.small)",
    syntax: ":not(X)",
    help : 'Tu puedes usar esto para seleccionar todos los elementos que no coincidan con el selector <strong>"X"</strong>.',
    examples : [
      '<strong>:not(#fancy)</strong> selecciona todos elementos que no tienen <strong>id="fancy"</strong>.',
      '<strong>div:not(:first-child)</strong> selecciona cada <tag>div</tag> que no sea el primer hijo.',
      '<strong>:not(.big, .medium)</strong> selecciona todos los elementos que no tienen <strong>class="big"</strong> o <strong>class="medium"</strong>.'
    ],
    board: "{a}(A)A(o)p"
  }
];
