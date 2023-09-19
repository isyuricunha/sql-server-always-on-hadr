--Compatível com SQL 2008
select cast(dateadd(mm, datediff(m, 0, getdate()) - 1,0) as datetime)                       --Primeiro dia do mês anterior 
select cast(dateadd(s, -1, dateadd(mm, datediff(m,0, getdate()) - 0, 0)) as  datetime)      --Último dia do mês anterior
select cast(dateadd(mm, datediff(m, 0, getdate()) + 0,0) as datetime)                       --Primeiro dia do mês atual
select cast(dateadd(s, -1, dateadd(mm, datediff(m,0, getdate()) + 1, 0)) as  datetime)      --Último dia do mês atual
select cast(dateadd(mm, datediff(m, 0, getdate()) + 1,0) as datetime)                       --Primeiro dia do próximo mês 
select cast(dateadd(s, -1, dateadd(mm, datediff(m,0, getdate()) + 2, 0)) as  datetime)      --Último dia do próximo mês 

--Compatível a partir do SQL 2014 em diante
select cast(dateadd(day, 1, eomonth(getdate(), -1)) as datetime)                            --Primeiro dia do mês 	
select cast(eomonth(getdate()) as datetime)                                                 --Último dia do mês atual
select cast(dateadd(day, 1, eomonth(getdate())) as datetime)                                --Primeiro dia do próximo mês atual
select cast(eomonth(getdate(), + 1) as datetime)                                            --Último dia do próximo mês 
select cast(dateadd(day, 1, eomonth(getdate(), -2)) as datetime)                            --Primeiro dia do mês anterior
select cast(eomonth(getdate(), - 1) as datetime)                                            --Último dia do mês anterior

------------------------------------------------------------------------------------------------------------------------------------------
set dateformat dmy;
declare @today as datetime
set @today = '23/10/2020';

--Compatível com SQL 2008
select cast(dateadd(mm, datediff(m, 0, @today) - 1,0) as datetime)                          --Primeiro dia do mês anterior      01/09/2020
select cast(dateadd(s, -1, dateadd(mm, datediff(m,0, @today) - 0, 0)) as  datetime)         --Último dia do mês anterior        30/09/2020
select cast(dateadd(mm, datediff(m, 0, @today) + 0,0) as datetime)                          --Primeiro dia do mês               01/10/2020
select cast(dateadd(s, -1, dateadd(mm, datediff(m,0, @today) + 1, 0)) as  datetime)         --Último dia do mês                 31/10/2020
select cast(dateadd(mm, datediff(m, 0, @today) + 1,0) as datetime)                          --Primeiro dia do próximo mês       01/11/2020
select cast(dateadd(s, -1, dateadd(mm, datediff(m, 0, @today) + 2, 0)) as  datetime)        --Último dia do próximo mês         30/11/2020

--Compatível a partir do SQL 2014 em diante
select cast(dateadd(day, 1, eomonth(@today, -2)) as datetime)                               --Primeiro dia do mês anterior      01/09/2020
select cast(eomonth(@today, - 1) as datetime)                                               --Último dia do mês anterior        30/09/2020
select cast(dateadd(day, 1, eomonth(@today, -1)) as datetime)                               --Primeiro dia do mês               01/10/2020
select cast(eomonth(@today) as datetime)                                                    --Último dia do mês                 31/10/2020
select cast(dateadd(day, 1, eomonth(@today)) as datetime)                                   --Primeiro dia do próximo mês       01/11/2020
select cast(eomonth(@today, + 1) as datetime)                                               --Último dia do próximo mês         30/11/2020
