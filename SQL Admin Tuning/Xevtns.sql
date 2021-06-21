CREATE EVENT SESSION [TSQLSP] ON SERVER 
ADD EVENT sqlserver.sp_statement_completed(
    ACTION(sqlserver.sql_text)
    WHERE ([sqlserver].[like_i_sql_unicode_string]([sqlserver].[database_name],N'northwind'))),
ADD EVENT sqlserver.sp_statement_starting(
    ACTION(sqlserver.sql_text)
    WHERE ([sqlserver].[like_i_sql_unicode_string]([sqlserver].[database_name],N'northwind'))),
ADD EVENT sqlserver.sql_batch_completed(
    ACTION(sqlserver.sql_text)
    WHERE ([sqlserver].[like_i_sql_unicode_string]([sqlserver].[database_name],N'northwind'))),
ADD EVENT sqlserver.sql_batch_starting(SET collect_batch_text=(1)
    ACTION(sqlserver.sql_text)
    WHERE ([sqlserver].[like_i_sql_unicode_string]([sqlserver].[database_name],N'northwind')))
ADD TARGET package0.event_file(SET filename=N'D:\_BACKUP\TSQLSP.xel'),
ADD TARGET package0.histogram(SET source=N'sqlserver.sql_text'),
ADD TARGET package0.ring_buffer(SET max_memory=(102400))
WITH (MAX_MEMORY=4096 KB,EVENT_RETENTION_MODE=ALLOW_SINGLE_EVENT_LOSS,MAX_DISPATCH_LATENCY=30 SECONDS,MAX_EVENT_SIZE=0 KB,MEMORY_PARTITION_MODE=NONE,TRACK_CAUSALITY=OFF,STARTUP_STATE=OFF)
GO

