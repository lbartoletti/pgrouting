BEGIN;

UPDATE edge_table SET cost = sign(cost), reverse_cost = sign(reverse_cost);
SELECT CASE WHEN min_version('4.0.0') THEN plan(22) ELSE plan(21) END;

PREPARE edges AS
SELECT id, source, target, cost, reverse_cost FROM edge_table;

PREPARE null_ret AS
SELECT id FROM edge_table_vertices_pgr  WHERE id IN (-1);


CREATE OR REPLACE FUNCTION test(params TEXT[], subs TEXT[])
RETURNS SETOF TEXT AS
$BODY$
DECLARE
mp TEXT[];
q1 TEXT;
q TEXT;
BEGIN
    FOR i IN 0..array_length(params, 1) LOOP
        mp := params;
        IF i != 0 THEN
            mp[i] = subs[i];
        END IF;

        q1 := format($$
            SELECT * FROM pgr_trspViaEdges(
                %1$L, %2$s, %3$s, %4$s, %5$s
            )
            $$,
            mp[1], mp[2], mp[3], mp[4], mp[5]
        );

        if i IN (1,3) THEN
            RETURN query SELECT * FROM throws_ok(q1);
        ELSE
            RETURN query SELECT * FROM lives_ok(q1, 'should live i ' || i);
            RETURN query SELECT * FROM is_empty(q1,  'should be empty i' || i);
        END IF;

    END LOOP;

END
$BODY$
LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION test_function()
RETURNS SETOF TEXT AS
$BODY$
DECLARE
params TEXT[];
subs TEXT[];
BEGIN
  IF min_version('4.0.0') THEN

    RETURN QUERY SELECT isnt_empty('edges', 'Should not be empty to tests be meaningful');
    RETURN QUERY SELECT is_empty('null_ret', 'Should be empty to tests be meaningful');

    params = ARRAY['$$SELECT id::INTEGER, source::INTEGER, target::INTEGER, cost::FLOAT, reverse_cost::FLOAT  FROM edge_table$$',
    'ARRAY[1, 2]',
    'ARRAY[0.5, 0.5]::FLOAT[]',
    'true',
    'true'
    ]::TEXT[];
    subs = ARRAY[
    'NULL',
    '(SELECT array_agg(id)::INTEGER[] FROM edge_table_vertices_pgr  WHERE id IN (-1))',
    'NULL::FLOAT[]',
    'NULL',
    'NULL'
    ]::TEXT[];
    RETURN query SELECT no_crash_test('pgr_trspViaEdges', params, subs);

    subs = ARRAY[
    'NULL',
    'NULL::INTEGER[]',
    'NULL::FLOAT[]',
    'NULL',
    'NULL'
    ]::TEXT[];
    RETURN query SELECT no_crash_test('pgr_trspViaEdges', params, subs);

  ELSE

    params = ARRAY['SELECT id::INTEGER, source::INTEGER, target::INTEGER, cost::FLOAT, reverse_cost::FLOAT  FROM edge_table',
    'ARRAY[1]',
    'ARRAY[1.5]::FLOAT[]',
    'true',
    'true'
    ]::TEXT[];
    subs = ARRAY[
    NULL,
    '(SELECT array_agg(id)::INTEGER[] FROM edge_table_vertices_pgr  WHERE id IN (-1))',
    'NULL::FLOAT[]',
    'NULL',
    'NULL'
    ]::TEXT[];

    RETURN query SELECT test(params, subs);

    subs = ARRAY[
    NULL,
    'NULL::INTEGER[]',
    'NULL::FLOAT[]',
    'NULL',
    'NULL'
    ]::TEXT[];
    RETURN query SELECT test(params, subs);

    RETURN QUERY SELECT skip(1, 'pgr_trspViaEdges Has some crashes');

  END IF;

END
$BODY$
LANGUAGE plpgsql VOLATILE;


SELECT test_function();

SELECT finish();
ROLLBACK;
