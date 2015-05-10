# Demarcation

* define scope of this talk

* only the View

* pattern for organizing application state later (June 8th)

## What React _is not_

* get some preconceptions out of the way

## What React _is_

# Motivation

## What makes Web Interfaces Complex?

* state

* transitions

* worse: have to manage transitions manually

## What makes Web Interfaces Complex? (2)

* in our case:

    * make sure to propagate state manually (through event listeners)

    * make sure to transition each layer's state manually

## The Problem

## Simplicity -- Reducing Cognitive Load

Our intellectual powers are rather geared to master static relations and that
our powers to visualize processes evolving in time are relatively poorly
developed. For that reason we should do (as wise programmers aware of our
limitations) our utmost to shorten the conceptual gap between the static
program and the dynamic process, to make the correspondence between the program
(spread out in text space) and the process (spread out in time) as trivial as
possible.

## Simplicity -- Predictability -- Robustness

# How can React help?

## Simplify Web Interfaces

* effectively make rendering idempotent

* no difference between initial render and changes

## React Components

* small API surface -> simple

* some additional lifecycle methods (mainly for integration)

## The Render Function
## Reconciliation
## Positive Effects

* render to string = isomorphic rendering

* render to native = react native

## Positive Effects (2)

* external signal needed (see next talk)

# Code Examples
## A Simple Component
## Rendering Components

* `React.render` can be applied to arbitrary DOM trees (taking over server-generated DOM)

## Composing Components
## Using Flow Control Structures

* full expressiveness of JavaScript and CoffeeScript

# Performance
## Inherent Performance Advantages
## Additional Optimizations: Render Tree Pruning
## Additional Optimizations: Immutable State

# Questions, Please -- Thank You
