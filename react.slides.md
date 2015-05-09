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

# How can React help?

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

<!--\begin{figure}
    \begin{tikzpicture}[
        %grow via three points={one child at (1,-1) and
        %two children at (1,-1) and (1,-2)},
        every node/.append style = dom node,
        edge from parent/.append style = propagation,
        dirtree,
    ]
        \node {ul(className='planning-object-list')}
            child { node {li(className='line')}
                child { node {div(className='violation-line')} }
                child { node {div(className='entry')} }
                child { node {ul()} }
            }
            child { node {li(className='line')} };
    \end{tikzpicture}
\end{figure}-->


## Positive Effects

Composable

:   components can be nested

Cachable

:   return values can be cached safely

Predictable

:   no hidden state

Flexible

:   virtual DOM can be rendered to DOM, string, native widgets, etc...


# Examples

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
