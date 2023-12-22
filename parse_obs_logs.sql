-- parse log file from obs studio
SELECT * exclude (time_val, fraction),
(date_val + time_val) + fraction as event_timestamp
FROM(
select 
	CAST(column0[:8] as time) time_val,
	to_milliseconds(CAST(column0[10:12] as int)) as fraction,
	trim(trim(trim(column0[14:]),'	')) as message,
	CAST(split_part(filename,'\',-1)[:10] as DATE) as date_val
from read_csv_auto('C:\Users\Public\Documents\*.txt', delim='', filename=True)
where message <> '---------------------------------' and len(message) <> 0)
--where event_timestamp between TIMESTAMP '' and TIMESTAMP '' -- when did the video drop out?
order by event_timestamp desc
