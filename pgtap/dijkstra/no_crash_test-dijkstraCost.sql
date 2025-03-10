BEGIN;


UPDATE edge_table SET cost = sign(cost), reverse_cost = sign(reverse_cost);
SELECT CASE WHEN min_version('3.1.0') THEN plan(81) ELSE plan(68) END;

SELECT no_crash_dijkstra('pgr_dijkstraCost');
SELECT finish();

ROLLBACK;
