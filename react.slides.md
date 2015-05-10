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

that implements

* a **virtual DOM**

* a **DOM diffing** and **patching** algorithm

# Motivation

## What makes Web Interfaces Complex?

### It's full of **state** and **transitions**

\begin{figure}
    \begin{tikzpicture}[auto]
        \node (model1) [block] {Model State 1};
        \node (model2) [block, right=of model1, visible on=<2->] {Model State 2};

        \node (dom1) [block, below=of model1] {DOM State 1};
        \node (dom2) [block, below=of model2, visible on=<3->] {DOM State 2};

        \graph {
            (model1) ->[transition, visible on=<2->] (model2);
            (dom1) ->[transition, visible on=<4->] (dom2);

            (model1) ->[propagation] (dom1);
            (model2) ->[propagation, visible on=<3->] (dom2);
        };

        \path (8,0) edge [->, propagation, "state propagation"] +(2,0);
        \path (8,-1) edge [->, transition, "explicit transition"] +(2,0);
    \end{tikzpicture}
\end{figure}

## What makes Web Interfaces Complex? (2)

### Even more so in our case

\begin{figure}
    \begin{tikzpicture}[auto]
        \def\states{1,2,3}
        \node (model1) [block] {Model State 1};
        \node (model2) [block, right=of model1] {Model State 2};

        \node (viewmodel1) [block, below right=1cm and 2cm of model1] {ViewModel State 1};
        \node (viewmodel2) [block, below right=1cm and 2cm of model2] {ViewModel State 2};

        \node (presenter1) [block, below=of model1] {Presenter};
        \node (presenter2) [block, below=of model2] {Presenter};

        \node (view1) [block, below=1cm of presenter1] {View State 2};
        \node (view2) [block, below=1cm of presenter2] {View State 2};

        \node (dom1) [block, below=1cm of view1] {DOM State 1};
        \node (dom2) [block, below=1cm of view2] {DOM State 2};

        \graph {
            (model1) ->[transition] (model2);
            (viewmodel1) ->[transition] (viewmodel2);
            (view1) ->[transition] (view2);
            (dom1) ->[transition] (dom2);

            (model1) ->[propagation] (presenter1);
            (model1) ->[propagation] (viewmodel1);
            (viewmodel1) ->[propagation] (presenter1);

            (presenter1) ->[propagation] (view1);
            (presenter2) ->[propagation] (view2);

            (model2) ->[propagation] (presenter2);
            (model2) ->[propagation] (viewmodel2);
            (viewmodel2) ->[propagation] (presenter2);

            (view1) ->[propagation] (dom1);
            (view2) ->[propagation] (dom2);
        };

        \path (10,0) edge [->, propagation, "state propagation"] +(2,0);
        \path (10,-1) edge [->, transition, "explicit transition"] +(2,0);
    \end{tikzpicture}
\end{figure}

## The Problem

* Complexity of **state** and **transitions**

* Tight **coupling** of

    * ViewModel

    * Presenter

    * View

    * Template

    * DOM

* Impedes

    * Reusability

    * Testability

    * Predictability


## Simplicity -- Reducing Cognitive Load

> [...] we should do (as wise programmers aware of our limitations) our utmost
> to **shorten the conceptual gap between the static program and the dynamic
> process**, to make the correspondence between the program (spread out in text
> space) and the process (spread out in time) as trivial as possible. 

--- E.W. Dijkstra (1968) "A Case against the GO TO Statement"


## Simplicity -- Predictability -- Robustness

* less context to keep in mind

* fewer mistakes

* fewer bugs

* easier to learn

* easier to adapt


# How can React help?

## Simplify Web Interfaces

### Re-render everything in case of changes

* Minimize redundant and scattered state

* Minimize the number of transitions (managed by the developer)

* Minimize side-effects

## React Components

\begin{description}[The render() function]
    \item[State] Internal component state (\emph{which should be minimal})
    \item[Properties] Externally supplied state
    \item[The render() function] Turns state and properties into a visual representation
\end{description}

## The Render Function

\begin{columns}[onlytextwidth]
    \begin{column}{\textwidth/2}
        \begin{itemize}
            \item stateless
            \item free of side-effects
            \item referentially transparent
        \end{itemize}
    \end{column}
    \begin{column}{\textwidth/2}
        \begin{figure}
            \begin{tikzpicture}
                \graph [
                    grow down = 1.5cm,
                    branch right = 3cm,
                    nodes = block,
                    edges = propagation,
                    edge quotes = {
                        black,
                        auto,
                    }
                    ] {
                    {
                        "application state" [visible on=<4->];
                        "component state" [visible on=<4->];
                    }
                    ->["signal update", visible on=<4->] {
                        "properties" [visible on=<2->];
                        "state" [visible on=<2->];
                    }
                    ->["use", visible on=<2->] "render()"
                    ->["return", visible on=<3->] "virtual DOM fragment" [visible on=<3->]
                    ->["reconcile", visible on=<5->] "DOM" [visible on=<5->];
                };
            \end{tikzpicture}
        \end{figure}
    \end{column}
\end{columns}

## Reconciliation

### DOM diffing and patching rules

* for element lists:

    * pairwise by key if given

    * pairwise by position otherwise

* pairwise comparison

    * different tag type treated as replacements

    * same tag type update attribute by attribute


## Positive Effects

Composable

:   components can be nested

Cachable

:   return values can be cached safely

Predictable

:   no hidden state

Flexible

:   virtual DOM can be rendered to DOM, string, native widgets, etc...

## Positive Effects (2)

* Simpler data flow
* Just update component properties on model change

\begin{figure}
    \begin{tikzpicture}[auto]
        \node (model1) [block] {Model State 1};
        \node (model2) [block, right=of model1] {Model State 2};

        \node (viewmodel1) [block, below right=1cm and 2cm of model1] {ViewModel State 1};
        \node (viewmodel2) [block, below right=1cm and 2cm of model2] {ViewModel State 2};

        \node (components1) [block, below=of model1] {React Components};
        \node (components2) [block, below=of model2] {React Components};

        \node (dom1) [block, below=of components1] {DOM State 1};
        \node (dom2) [block, below=of components2] {DOM State 2};

        \graph {
            (model1) ->[transition] (model2);
            (viewmodel1) ->[transition] (viewmodel2);
            (dom1) ->[implicit transition] (dom2);

            (model1) ->[propagation] (components1);
            (model1) ->[propagation] (viewmodel1);
            (viewmodel1) ->[propagation] (components1);
            (components1) ->[implicit transition] (dom1);

            (model2) ->[propagation] (components2);
            (model2) ->[propagation] (viewmodel2);
            (viewmodel2) ->[propagation] (components2);
            (components2) ->[implicit transition] (dom2);
        };

        \path (10,0) edge [->, propagation, "state propagation"] +(2,0);
        \path (10,-1) edge [->, transition, "explicit transition"] +(2,0);
        \path (10,-2) edge [->, implicit transition, "implicit propagation/transition"] +(2,0);
    \end{tikzpicture}
\end{figure}


# Code Examples

## A Simple Component

```{.coffee .numberLines}
React = require 'react'
{div} = React.DOM

class LineNumberColumn extends React.Component
    @propTypes =
        value: React.PropTypes.number.isRequired

    render: ->
        div className: 'lineNumber', @props.value

module.exports = {
    LineNumberColumn
}
```

## Rendering Components

```{.coffee .numberLines}
React = require 'react'
{LineNumberColumn} = require './columns'

targetElement = document.querySelector '#demoTarget'

viewModel.on 'change', ->
    virtualElement = React.createElement(LineNumberColumn, value: viewModel.lineNumber)
    React.render virtualElement, targetElement
```

## Composing Components

```{.coffee .numberLines}
{DOM: {div}} = React = require 'react'

{LineNumberColumn, ExpandColumn, NameColumn} = require './columns'

class TreeRowContent extends React.Component
    @propTypes =
        planningObject: React.PropTypes.object.isRequired

    render: ->
        div className: 'content',
            div {},
                React.createElement LineNumberColumn, value: @props.lineNumber
                div className: 'rowContent',
                    React.createElement ExpandColumn {}
                    React.createElement NameColumn value: @props.name
                    # ...
```

## Using Flow Control Structures

```{.coffee .numberLines}
{DOM: {li, ul}} = React = require 'react'
classNames = require 'classnames'

class TreeRow extends React.Component
    @propTypes =
        planningObject: React.PropTypes.object.isRequired
        level: React.PropTypes.number
    @defaultProps =
        level: 0
    render: ->
        {planningObject, level} = @props
        classes = classNames "level-#{level}",
            hasChildren: planningObject.children.length > 0

        li className: classes,
            React.createElement TreeRowContent, planningObject: planningObject
            ul className: 'children', for child in planningObject.children
                React.createElement TreeRow, planningObject: child, level: @level + 1
```

# Performance

## Inherent Performance Advantages

### Performance is not the main focus, but a bonus

* The virtual DOM is fast

* The real (slow) DOM is only modified selectively

* Plain JavaScript automatically benefits from future runtime optimization

* Can be rendered server-side to reduce initial load time


## Additional Optimizations: Render Tree Pruning

### `shouldComponentUpdate()`{.coffee}

* Called when state or properties might have changed

* Component decides whether `render()`{.coffee} will be called by comparing old and new state

* The default implementation always returns `true`{.coffee}

* If it returns `false`{.coffee}, the previous virtual DOM is reused

```{.coffee .numberLines}
class LineNumberColumn extends React.Component
    shouldComponentUpdate: (newProps, newState) ->
        newProps.value isnt @props.value

    render: ->
        div className: 'lineNumber', @props.value
```


## Additional Optimizations: Immutable State

### Immutable State

* Pass state and properties as **immutable data structures**, e.g. Facebook's Immutable.js

* $O(1)$ equality checks of arbitrarily complex objects

* Easier reasoning about state changes

```{.coffee .numberLines}
class TreeRowContent extends React.Component
    shouldComponentUpdate: (newProps, newState) ->
        not Immutable.is newProps.planningObject, @props.planningObject

    render: ->
        # ...
```

# Questions, Please -- Thank You
