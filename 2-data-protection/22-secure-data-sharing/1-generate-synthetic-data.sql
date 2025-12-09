-- see https://docs.snowflake.com/en/sql-reference/stored-procedures/generate_synthetic_data

-- Two columns designated as join keys
CALL SNOWFLAKE.DATA_PRIVACY.GENERATE_SYNTHETIC_DATA({
    'datasets':[
        {
          'input_table': 'syndata_db.sch.faker_source_t',
          'output_table': 'syndata_db.sch.faker_synthetic_t',
          'columns': { 'blood_type': {'join_key': TRUE} , 'ethnicity': {'join_key': TRUE}}
        }
      ]
  });

-- No columns designated as join keys
CALL SNOWFLAKE.DATA_PRIVACY.GENERATE_SYNTHETIC_DATA({
  'datasets':[
      {
        'input_table': 'syndata_db.sch.faker_source_t',
        'output_table': 'syndata_db.sch.faker_synthetic_t'
      }
    ]
});

-- Use consistency key to generate consistent values across multiple runs
CREATE OR REPLACE SECRET my_db.public.my_consistency_secret
  TYPE = SYMMETRIC_KEY
  ALGORITHM = GENERIC;

CALL SNOWFLAKE.DATA_PRIVACY.GENERATE_SYNTHETIC_DATA({
  'datasets':[
      {
        'input_table': 'CLINICAL_DB.PUBLIC.BASE_TABLE',
        'output_table': 'my_db.public.test_syndata',
        'columns': { 'patient_id': {'join_key': TRUE, 'replace': 'uuid'}}
      }
    ],
    'consistency_secret': SYSTEM$REFERENCE('SECRET', 'MY_CONSISTENCY_SECRET', 'SESSION', 'READ')::STRING,
    'replace_output_tables': TRUE
});
