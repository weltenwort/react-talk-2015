% React
% Felix Stürmer
% May 11, 2015

# Demarcation

## What React _is not_

### React _is not_...

* an architecture (like MVC)

* a web framework (like Ember.js)

* a functional reactive programming (FRP) library (like RXJS or bacon.js)

## What React _is_

### React _is_...

* a **view library**

. . .

that implements

* a **virtual DOM**

* a **DOM diffing** and **patching** algorithm

# Simplicity

## Simplicity -- Reducing Cognitive Load

> [...] we should do (as wise programmers aware of our limitations) our utmost
> to **shorten the conceptual gap between the static program and the dynamic
> process**, to make the correspondence between the program (spread out in text
> space) and the process (spread out in time) as trivial as possible. 

--- E.W. Dijkstra (1968) "A Case against the GO TO Statement"


\note[item]{Our intellectual powers are rather geared to master static relations and that our powers to visualize processes evolving in time are relatively poorly developed. For that reason we should do (as wise programmers aware of our limitations) our utmost to shorten the conceptual gap between the static program and the dynamic process, to make the correspondence between the program (spread out in text space) and the process (spread out in time) as trivial as possible.}

## Simplicity -- Predictability -- Robustness

* less context to keep in mind

    * fewer mistakes

    * fewer bugs

* easier to **learn**

* easier to **adapt**

# Complexity in Web Interfaces

## Why are Web Interfaces Complex

### It's full of **state** and **transitions**:

\tikzset{
    every node/.style = {
        node distance = 3cm,
        font = \sffamily\small,
        on grid,
    },
    block/.style = {
        rectangle,
        rounded corners,
        draw = mDarkTeal,
        thick,
    },
    transition/.style = {
        ->,
        dashed,
        mLightBrown,
        thick,
    },
}

\begin{tikzpicture}[auto]
    \node (model1) [block] {Model State 1};
    \node (model2) [block, right of=model1] {Model State 2};
    \node (model3) [block, right of=model2] {Model State 3};

    \node (view1) [block, below of=model1] {View State 1};
    \node (view2) [block, right of=view1] {View State 2};
    \node (view3) [block, right of=view2] {View State 3};

    \draw [transition] (model1) -- (model2);
    \draw [transition] (model2) -- (model3);
\end{tikzpicture}

<!--
      section
        h2 How does React tacle that?
        ul
          li
            span Cohesive, composable 
            em components
          li
            em Stateless
            span , 
            em pure 
            span render functions
            ul
              li
                span Input: 
                em state
                span , 
                em properties
              li
                span Output: 
                em virtual DOM elements

      section
        .mermaid.
          graph LR
            classDef default stroke:#728DA5,stroke-width:2px;
            linkStyle defaulDEFAULTt stroke:#728DA5,stroke-width:2px;
            subgraph Model
              model1(State 1)
              model2(State 2)
              model1->model2
            end

      section
        pre.line-numbers
          code.language-coffeescript.
            bespoke.from 'article', [
              classes(),
              keys(),
              touch(),
              bullets('li, .bullet')
            ]
      section
        h2 template in my js?
-->
