..
   ****************************************************************************
    pgRouting Manual
    Copyright(c) pgRouting Contributors

    This documentation is licensed under a Creative Commons Attribution-Share
    Alike 3.0 License: https://creativecommons.org/licenses/by-sa/3.0/
   ****************************************************************************

|

* **Supported versions:**
  `Latest <https://docs.pgrouting.org/latest/en/pgr_bdDijkstraCost.html>`__
  (`3.3 <https://docs.pgrouting.org/3.3/en/pgr_bdDijkstraCost.html>`__)
  `3.2 <https://docs.pgrouting.org/3.2/en/pgr_bdDijkstraCost.html>`__
  `3.1 <https://docs.pgrouting.org/3.1/en/pgr_bdDijkstraCost.html>`__
  `3.0 <https://docs.pgrouting.org/3.0/en/pgr_bdDijkstraCost.html>`__
* **Unsupported versions:**
  `2.6 <https://docs.pgrouting.org/2.6/en/pgr_bdDijkstraCost.html>`__
  `2.5 <https://docs.pgrouting.org/2.5/en/pgr_bdDijkstraCost.html>`__

``pgr_bdDijkstraCost``
===============================================================================

``pgr_bdDijkstraCost`` — Returns the shortest path(s)'s cost using Bidirectional
Dijkstra algorithm.

.. figure:: images/boost-inside.jpeg
   :target: https://www.boost.org/libs/graph/doc/table_of_contents.html

   Boost Graph Inside

.. rubric:: Availability

* Version 3.2.0

  * New **proposed** signature:

    * ``pgr_bdDijkstraCost`` (`Combinations`_)

* Version 3.0.0

  * **Official** function

* Version 2.5.0

  * New **proposed** function


Description
-------------------------------------------------------------------------------

The ``pgr_bdDijkstraCost`` function sumarizes of the cost of the shortest path
using the bidirectional Dijkstra Algorithm.

.. include:: bdDijkstra-family.rst
    :start-after: description start
    :end-before: description end

.. include:: cost-category.rst
    :start-after: cost_traits_start
    :end-before: cost_traits_end

Signatures
-------------------------------------------------------------------------------

.. rubric:: Summary

.. parsed-literal::

    pgr_bdDijkstraCost(`Edges SQL`_, **start vid**, **end vid**  [, directed])
    pgr_bdDijkstraCost(`Edges SQL`_, **start vid**, **end vids** [, directed])
    pgr_bdDijkstraCost(`Edges SQL`_, **start vids**, **end vid**  [, directed])
    pgr_bdDijkstraCost(`Edges SQL`_, **start vids**, **end vids** [, directed])
    pgr_bdDijkstraCost(`Edges SQL`_, `Combinations SQL`_ [, directed])
    RETURNS SET OF (start_vid, end_vid, agg_cost)
    OR EMPTY SET

.. index::
    single: bdDijkstraCost(One to One)

One to One
...............................................................................

.. parsed-literal::

    pgr_bdDijkstraCost(`Edges SQL`_, **start vid**, **end vid**  [, directed])
    RETURNS SET OF (start_vid, end_vid, agg_cost)
    OR EMPTY SET

:Example: From vertex :math:`6` to vertex  :math:`10` on a **directed** graph

.. literalinclude:: doc-pgr_bdDijkstraCost.queries
    :start-after: -- q2
    :end-before: -- q3

.. index::
    single: bdDijkstraCost(One to Many)

One to Many
...............................................................................

.. parsed-literal::

    pgr_bdDijkstraCost(`Edges SQL`_, **start vid**, **end vids** [, directed])
    RETURNS SET OF (start_vid, end_vid, agg_cost)
    OR EMPTY SET

:Example: From vertex :math:`6` to vertices :math:`\{10, 17\}` on a **directed**
          graph

.. literalinclude:: doc-pgr_bdDijkstraCost.queries
    :start-after: -- q3
    :end-before: -- q4

.. index::
    single: bdDijkstraCost(Many to One)

Many to One
...............................................................................

.. parsed-literal::

    pgr_bdDijkstraCost(`Edges SQL`_, **start vids**, **end vid**  [, directed])
    RETURNS SET OF (start_vid, end_vid, agg_cost)
    OR EMPTY SET

:Example: From vertices :math:`\{6, 1\}` to vertex :math:`17` on a **directed**
          graph

.. literalinclude:: doc-pgr_bdDijkstraCost.queries
    :start-after: -- q4
    :end-before: -- q5

.. index::
    single: bdDijkstraCost(Many to Many)

Many to Many
...............................................................................

.. parsed-literal::

    pgr_bdDijkstraCost(`Edges SQL`_, **start vids**, **end vids** [, directed])
    RETURNS SET OF (start_vid, end_vid, agg_cost)
    OR EMPTY SET

:Example: From vertices :math:`\{6, 1\}` to vertices :math:`\{10, 17\}` on an
          **undirected** graph

.. literalinclude:: doc-pgr_bdDijkstraCost.queries
    :start-after: -- q5
    :end-before: -- q51

.. index::
    single: bdDijkstraCost(Combinations) - Proposed on v3.2

Combinations
...............................................................................

.. parsed-literal::

    pgr_bdDijkstraCost(`Edges SQL`_, `Combinations SQL`_ [, directed])
    RETURNS SET OF (start_vid, end_vid, agg_cost)
    OR EMPTY SET

:Example: Using a combinations table on an **undirected** graph

The combinations table:

.. literalinclude:: doc-pgr_bdDijkstraCost.queries
    :start-after: -- q51
    :end-before: -- q52

The query:

.. literalinclude:: doc-pgr_bdDijkstraCost.queries
    :start-after: -- q52
    :end-before: -- q6

Parameters
-------------------------------------------------------------------------------

.. include:: dijkstra-family.rst
    :start-after: dijkstra_parameters_start
    :end-before: dijkstra_parameters_end

Optional parameters
...............................................................................

.. include:: dijkstra-family.rst
    :start-after: dijkstra_optionals_start
    :end-before: dijkstra_optionals_end

Inner Queries
-------------------------------------------------------------------------------

Edges SQL
...............................................................................

.. include:: pgRouting-concepts.rst
    :start-after: basic_edges_sql_start
    :end-before: basic_edges_sql_end

Combinations SQL
...............................................................................

.. include:: pgRouting-concepts.rst
    :start-after: basic_combinations_sql_start
    :end-before: basic_combinations_sql_end

Result Columns
-------------------------------------------------------------------------------

.. include:: pgRouting-concepts.rst
    :start-after: return_cost_start
    :end-before: return_cost_end

Additional Examples
-------------------------------------------------------------------------------

:Example 1: Demonstration of repeated values are ignored, and result is sorted.

.. literalinclude:: doc-pgr_bdDijkstraCost.queries
    :start-after: -- q6
    :end-before: -- q7

:Example 2: Making **start vids** the same as **end vids**.

.. literalinclude:: doc-pgr_bdDijkstraCost.queries
    :start-after: -- q7
    :end-before: -- q8

:Example 3: Manually assigned vertex combinations.

.. literalinclude:: doc-pgr_bdDijkstraCost.queries
    :start-after: -- q8
    :end-before: -- q9

See Also
-------------------------------------------------------------------------------

* :doc:`bdDijkstra-family`
* :doc:`sampledata`
* https://www.cs.princeton.edu/courses/archive/spr06/cos423/Handouts/EPP%20shortest%20path%20algorithms.pdf
* https://en.wikipedia.org/wiki/Bidirectional_search

.. rubric:: Indices and tables

* :ref:`genindex`
* :ref:`search`
