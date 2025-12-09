-- share data in non-secure views --> for query optimizations, create/alter share
-- see https://docs.snowflake.com/en/user-guide/data-sharing-views

-- for new share
CREATE SHARE share1 SECURE_OBJECTS_ONLY = FALSE;

GRANT SELECT ON VIEW view1 TO SHARE share1;

-- for existing share
SHOW GRANTS TO SHARE share2;
SHOW GRANTS OF SHARE share2;

ALTER SHARE share2 SET SECURE_OBJECTS_ONLY = FALSE;
ALTER VIEW view2 UNSET SECURE;
