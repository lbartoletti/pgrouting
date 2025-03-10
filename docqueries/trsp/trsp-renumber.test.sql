


SELECT * FROM pgr_trsp(
    'SELECT id::INTEGER, (source+10)::INTEGER AS source, (target+10)::INTEGER AS target, cost::FLOAT FROM edges',
    11, 27, false, false
);

SELECT * FROM _pgr_trsp(
    'SELECT id::INTEGER, source::INTEGER, target::INTEGER, cost FROM edges',
    $$ SELECT 1 AS id, ARRAY[4,7] AS path, 100 AS cost $$,
    6, 1, false
);

SELECT * FROM _pgr_trsp(
    'SELECT id::INTEGER, source::INTEGER, target::INTEGER, cost FROM edges',
    $$ SELECT * FROM new_restrictions $$,
    6, 1, false
);


SELECT * FROM pgr_trsp(
    'SELECT id::INTEGER, source::INTEGER, target::INTEGER, cost FROM edges',
    6, 1, false, false,
    'SELECT to_cost, target_id::int4,
    from_edge || coalesce('','' || via_path, '''') AS via_path
    FROM restrictions'
);




