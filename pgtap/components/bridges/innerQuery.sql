BEGIN;

UPDATE edge_table SET cost = sign(cost), reverse_cost = sign(reverse_cost);
SELECT plan(55);


SELECT has_function('pgr_bridges',
    ARRAY['text']);


SELECT style_dijkstra('pgr_bridges', ')');

SELECT finish();
ROLLBACK;
