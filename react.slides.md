% React
% Felix Stürmer
% May 11, 2015

# Demarcation

## What React _is not_

React _is not_...

* an architecture (like MVC)
* a web framework (like Ember.js)

## What React _is_

React _is_...

* a **view library**

. . .

that implements

* a **virtual DOM**
* a **DOM diffing** and **patching** algorithm

# Simplicity

## Cognitive Load

> [...] we should do (as wise programmers aware of our limitations) our utmost
to **shorten the conceptual gap between the static program and the dynamic
process**, to make the correspondence between the program (spread out in text
space) and the process (spread out in time) as trivial as possible. 

--- E.W. Dijkstra (1968) "A Case against the GO TO Statement"

\note[item]{Our intellectual powers are rather geared to master static relations and that our powers to visualize processes evolving in time are relatively poorly developed. For that reason we should do (as wise programmers aware of our limitations) our utmost to shorten the conceptual gap between the static program and the dynamic process, to make the correspondence between the program (spread out in text space) and the process (spread out in time) as trivial as possible.}

<!--
      section
        h2 to achieve
        ul
          li
            em Simplicity
        h2 through
        ul
          li
            em Robustness
          li
            em Predictability

      section
        h2 The obligatory quote
        blockquote
          span [...] we should do (as wise programmers aware of our limitations) our utmost to 
          em shorten the conceptual gap between the static program and the dynamic process
          span , to make the correspondence between the program (spread out in text space) and the process (spread out in time) as trivial as possible. 
        p.citation E.W. Dijkstra (1968) "A Case against the GO TO Statement"
        aside
          p obligatory quote
          blockquote
            p Our intellectual powers are rather geared to master static relations and that our powers to visualize processes evolving in time are relatively poorly developed. For that reason we should do (as wise programmers aware of our limitations) our utmost to shorten the conceptual gap between the static program and the dynamic process, to make the correspondence between the program (spread out in text space) and the process (spread out in time) as trivial as possible. 
          p by Dijkstra

      section
        h2 Why Simplicity
        ul
          li less to keep in mind
          li 
            span fewer mistakes, 
            em fewer bugs
          li
            span easier to 
            em learn
          li 
            span easier to 
            em adapt

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
