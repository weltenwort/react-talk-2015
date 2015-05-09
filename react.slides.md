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

<!--\note[item]{Our intellectual powers are rather geared to master static relations and that our powers to visualize processes evolving in time are relatively poorly developed. For that reason we should do (as wise programmers aware of our limitations) our utmost to shorten the conceptual gap between the static program and the dynamic process, to make the correspondence between the program (spread out in text space) and the process (spread out in time) as trivial as possible.}-->

## Simplicity -- Predictability -- Robustness

* less context to keep in mind

    * fewer mistakes

    * fewer bugs

* easier to **learn**

* easier to **adapt**


## Is A Web Interface Simple?

### It's full of **state** and **transitions**

\tikzset{
    every node/.style = {
        node distance = 2cm and 5cm,
        text = white,
        font = \sffamily\small,
        on grid,
    },
    block/.style = {
        rectangle,
        rounded corners,
        fill = mDarkTeal,
        thick,
    },
    transition/.style = {
        dashed,
        mLightBrown,
        thick,
    },
    propagation/.style = {
        mLightBrown,
        thick,
    },
}

\begin{figure}
    \only<1>{
    \begin{tikzpicture}[auto]
        \node (model1) [block] {Model State 1};
        \node (model2) [block, right=of model1] {Model State 2};
        \node (model3) [block, right=of model2] {Model State 3};

        \node (dom1) [block, below=of model1] {DOM State 1};
        \node (dom2) [block, below=of model2] {DOM State 2};
        \node (dom3) [block, below=of model3] {DOM State 3};

        \graph {
            (model1) ->[transition] (model2) ->[transition] (model3);
            (dom1) ->[transition] (dom2) ->[transition] (dom3);

            (model1) ->[propagation] (dom1);
            (model2) ->[propagation] (dom2);
            (model3) ->[propagation] (dom3);
        };
    \end{tikzpicture}
    }

    \only<2>{
    \begin{tikzpicture}[auto]
        \def\states{1,2,3}
        \node (model1) [block] {Model State 1};
        \node (model2) [block, right=of model1] {Model State 2};
        \node (model3) [block, right=of model2] {Model State 3};

        \node (viewmodel1) [block, below right=1cm and 2cm of model1] {ViewModel State 1};
        \node (viewmodel2) [block, below right=1cm and 2cm of model2] {ViewModel State 2};
        \node (viewmodel3) [block, below right=1cm and 2cm of model3] {ViewModel State 3};

        \node (presenter1) [block, below=of model1] {Presenter};
        \node (presenter2) [block, below=of model2] {Presenter};
        \node (presenter3) [block, below=of model3] {Presenter};

        \node (view1) [block, below=1cm of presenter1] {View State 2};
        \node (view2) [block, below=1cm of presenter2] {View State 2};
        \node (view3) [block, below=1cm of presenter3] {View State 3};

        \node (dom1) [block, below=1cm of view1] {DOM State 1};
        \node (dom2) [block, below=1cm of view2] {DOM State 2};
        \node (dom3) [block, below=1cm of view3] {DOM State 3};

        \graph {
            (model1) ->[transition] (model2) ->[transition] (model3);
            (viewmodel1) ->[transition] (viewmodel2) ->[transition] (viewmodel3);
            (view1) ->[transition] (view2) ->[transition] (view3);
            (dom1) ->[transition] (dom2) ->[transition] (dom3);

            (model1) ->[propagation] (presenter1);
            (model1) ->[propagation] (viewmodel1);
            (viewmodel1) ->[propagation] (presenter1);

            (model2) ->[propagation] (presenter2);
            (model2) ->[propagation] (viewmodel2);
            (viewmodel2) ->[propagation] (presenter2);

            (model3) ->[propagation] (presenter3);
            (model3) ->[propagation] (viewmodel3);
            (viewmodel3) ->[propagation] (presenter3);

            (presenter1) ->[propagation] (view1) ->[propagation] (dom1);
            (presenter2) ->[propagation] (view2) ->[propagation] (dom2);
            (presenter3) ->[propagation] (view3) ->[propagation] (dom3);
        };
    \end{tikzpicture}
    }
\end{figure}

<!--\begin{tikzpicture}[auto]-->
<!--\node (model1) [block] {Model State 1};-->
<!--\node (model2) [block, right of=model1] {Model State 2};-->
<!--\node (model3) [block, right of=model2] {Model State 3};-->

<!--\node (view1) [block, below of=model1] {View State 1};-->
<!--\node (view2) [block, right of=view1] {View State 2};-->
<!--\node (view3) [block, right of=view2] {View State 3};-->

<!--\draw [transition] (model1) -- (model2);-->
<!--\draw [transition] (model2) -- (model3);-->
<!--\end{tikzpicture}-->

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
