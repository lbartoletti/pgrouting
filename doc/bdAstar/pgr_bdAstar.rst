..
   ****************************************************************************
    pgRouting Manual
    Copyright(c) pgRouting Contributors

    This documentation is licensed under a Creative Commons Attribution-Share
    Alike 3.0 License: https://creativecommons.org/licenses/by-sa/3.0/
   ****************************************************************************

|

* **Supported versions:**
  `Latest <https://docs.pgrouting.org/latest/en/pgr_bdAstar.html>`__
  (`3.3 <https://docs.pgrouting.org/3.3/en/pgr_bdAstar.html>`__)
  `3.2 <https://docs.pgrouting.org/3.2/en/pgr_bdAstar.html>`__
  `3.1 <https://docs.pgrouting.org/3.1/en/pgr_bdAstar.html>`__
  `3.0 <https://docs.pgrouting.org/3.0/en/pgr_bdAstar.html>`__
* **Unsupported versions:**
  `2.6 <https://docs.pgrouting.org/2.6/en/pgr_bdAstar.html>`__
  `2.5 <https://docs.pgrouting.org/2.5/en/pgr_bdAstar.html>`__
  `2.4 <https://docs.pgrouting.org/2.4/en/pgr_bdAstar.html>`__
  `2.3 <https://docs.pgrouting.org/2.3/en/src/bd_astar/doc/pgr_bdAstar.html>`__
  `2.2 <https://docs.pgrouting.org/2.2/en/src/bd_astar/doc/pgr_bdAstar.html>`__
  `2.1 <https://docs.pgrouting.org/2.1/en/src/astar/doc/index.html>`__
  `2.0 <https://docs.pgrouting.org/2.0/en/src/astar/doc/index.html>`__

``pgr_bdAstar``
===============================================================================

``pgr_bdAstar`` — Shortest path using the bidirectional A* algorithm.

.. figure:: images/boost-inside.jpeg
   :target: https://www.boost.org/libs/graph/doc/astar_search.html

   Boost Graph Inside

.. rubric:: Availability

* Version 3.2.0

  * New **proposed** signature:

    * ``pgr_bdAstar`` (`Combinations`_)

* Version 3.0.0

  * **Official** function

* Version 2.5.0

  * New **Proposed** signatures:

    * ``pgr_bdAstar`` (`One to Many`_)
    * ``pgr_bdAstar`` (`Many to One`_)
    * ``pgr_bdAstar`` (`Many to Many`_)

  * Signature change on ``pgr_bdAstar`` (`One to One`_)

    * Old signature no longer supported

* Version 2.0.0

  * **Official** ``pgr_bdAstar`` (`One to One`_)


Description
-------------------------------------------------------------------------------

**The main characteristics are:**

.. include:: aStar-family.rst
   :start-after: astar general info start
   :end-before: astar general info end

* The results are equivalent to the union of the results of the `pgr_bdAStar(`
  `One to One`_ `)` on the:

  * `pgr_bdAstar(` `One to Many`_ `)`
  * `pgr_bdAstar(` `Many to One`_ `)`
  * `pgr_bdAstar(` `Many to Many`_ `)`

* ``start_vid`` and ``end_vid`` in the result is used to distinguish to which
  path it belongs.

Signatures
-------------------------------------------------------------------------------

.. rubric:: Summary

.. parsed-literal::

   pgr_bdAstar(`Edges SQL`_, **start vid**, **end vid**
               [, directed] [, heuristic] [, factor] [, epsilon])
   pgr_bdAstar(`Edges SQL`_, **start vid**, **end vids**
               [, directed] [, heuristic] [, factor] [, epsilon])
   pgr_bdAstar(`Edges SQL`_, **start vids**, **end vid**
               [, directed] [, heuristic] [, factor] [, epsilon])
   pgr_bdAstar(`Edges SQL`_, **start vids**, **end vids**
               [, directed] [, heuristic] [, factor] [, epsilon])
   pgr_bdAstar(`Edges SQL`_, `Combinations SQL`_
               [, directed] [, heuristic] [, factor] [, epsilon])
   RETURNS (seq, path_seq [, start_vid] [, end_vid], node, edge, cost, agg_cost)
   OR EMPTY SET

Optional parameters are `named parameters` and have a default value.

.. index::
    single: bdAstar(One to One)

One to One
...............................................................................

.. parsed-literal::

    pgr_bdAstar(`Edges SQL`_, **start vid**, **end vid**
               [, directed] [, heuristic] [, factor] [, epsilon])
    RETURNS SET OF (seq, path_seq, node, edge, cost, agg_cost)
    OR EMPTY SET

:Example: From vertex :math:`6` to vertex :math:`12` on a **directed** graph
          with heuristic :math:`2`

.. literalinclude:: doc-pgr_bdAstar.queries
   :start-after: -- q2
   :end-before: -- q3

.. index::
    single: bdAstar(One to Many)

One to Many
...............................................................................

.. parsed-literal::

    pgr_bdAstar(`Edges SQL`_, **start vid**, **end vids**
               [, directed] [, heuristic] [, factor] [, epsilon])
    RETURNS (seq, path_seq, end_vid, node, edge, cost, agg_cost)
    OR EMPTY SET

:Example: From vertex :math:`6` to vertices :math:`\{10, 12\}` on a **directed**
          graph with heuristic :math:`3` and factor :math:`3.5`

.. literalinclude:: doc-pgr_bdAstar.queries
   :start-after: -- q3
   :end-before: -- q4

.. index::
    single: bdAstar(Many to One)

Many to One
...............................................................................

.. parsed-literal::

    pgr_bdAstar(`Edges SQL`_, **start vids**, **end vid**
               [, directed] [, heuristic] [, factor] [, epsilon])
    RETURNS (seq, path_seq, start_vid, node, edge, cost, agg_cost)
    OR EMPTY SET

:Example: From vertices :math:`\{6, 8\}` to vertex :math:`10` on an
          **undirected** graph with heuristic :math:`4`

.. literalinclude:: doc-pgr_bdAstar.queries
   :start-after: -- q4
   :end-before: -- q5

.. index::
    single: bdAstar(Many to Many)

Many to Many
...............................................................................

.. parsed-literal::

    pgr_bdAstar(`Edges SQL`_, **start vids**, **end vids**
               [, directed] [, heuristic] [, factor] [, epsilon])
    RETURNS (seq, path_seq, start_vid, end_vid, node, edge, cost, agg_cost)
    OR EMPTY SET

:Example: From vertices :math:`\{6, 8\}` to vertices :math:`\{10, 12\}` on a
          **directed** graph with factor :math:`0.5`

.. literalinclude:: doc-pgr_bdAstar.queries
   :start-after: -- q5
   :end-before: -- q51

.. index::
    single: bdAstar(Combinations) - Proposed on v3.2

Combinations
...............................................................................

.. parsed-literal::

    pgr_bdAstar(`Edges SQL`_, `Combinations SQL`_
               [, directed] [, heuristic] [, factor] [, epsilon])
    RETURNS (seq, path_seq, start_vid, end_vid, node, edge, cost, agg_cost)
    OR EMPTY SET

:Example: Using a combinations table on a **directed** graph with factor
          :math:`0.5`.

The combinations table:

.. literalinclude:: doc-pgr_bdAstar.queries
   :start-after: -- q51
   :end-before: -- q52

The query:

.. literalinclude:: doc-pgr_bdAstar.queries
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

aStar optional Parameters
...............................................................................

.. include:: aStar-family.rst
    :start-after: astar_optionals_start
    :end-before: astar_optionals_end

Inner Queries
-------------------------------------------------------------------------------

Edges SQL
...............................................................................

.. include:: pgRouting-concepts.rst
    :start-after: xy_edges_sql_start
    :end-before: xy_edges_sql_end

Combinations SQL
...............................................................................

.. include:: pgRouting-concepts.rst
    :start-after: basic_combinations_sql_start
    :end-before: basic_combinations_sql_end

Result Columns
-------------------------------------------------------------------------------

.. include:: pgRouting-concepts.rst
    :start-after: return_path_short_start
    :end-before: return_path_short_end

Additional Examples
-------------------------------------------------------------------------------

:Example 1: Demonstration of repeated values are ignored, and result is sorted.

.. literalinclude:: doc-pgr_bdAstar.queries
    :start-after: -- q6
    :end-before: -- q7

:Example 2: Making **start vids** the same as **end vids**.

.. literalinclude:: doc-pgr_bdAstar.queries
    :start-after: -- q7
    :end-before: -- q8

:Example 3: Manually assigned vertex combinations.

.. literalinclude:: doc-pgr_bdAstar.queries
   :start-after: -- q8
   :end-before: -- q9

See Also
-------------------------------------------------------------------------------

* :doc:`aStar-family`
* :doc:`bdAstar-family`
* :doc:`sampledata`
* https://www.boost.org/libs/graph/doc/astar_search.html
* https://en.wikipedia.org/wiki/A*_search_algorithm

.. rubric:: Indices and tables

* :ref:`genindex`
* :ref:`search`

