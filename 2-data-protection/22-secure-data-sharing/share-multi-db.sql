-- share data from multiple dbs --> w/ secure view
-- must grant REFERENCE_USAGE on dbs other than where the view is defined
-- see https://docs.snowflake.com/en/user-guide/data-sharing-multiple-db

CREATE SECURE VIEW db1.sch.view AS
  SELECT v1.id, t2.id
  FROM db1.sch.view1 v1, db2.sch.t2 t2;

CREATE SHARE share1;
GRANT USAGE ON DATABASE db1 TO SHARE share1;
GRANT USAGE ON SCHEMA db1.sch TO SHARE share1;

GRANT REFERENCE_USAGE ON DATABASE db2 TO SHARE share1;
GRANT SELECT ON VIEW db1.sch.view TO SHARE share1;
