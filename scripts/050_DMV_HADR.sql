
--CLUSTERS
SELECT * FROM SYS.dm_hadr_cluster
--MENBROS DO CLUSTER
SELECT * FROM SYS.dm_hadr_cluster_members

--REDES DE CLUSTER
SELECT * FROM SYS.dm_hadr_cluster_networks

--ESTADO DAS REPLICAS
SELECT * FROM SYS.dm_hadr_availability_replica_states

--NÓS DO CLUSTER
SELECT * FROM SYS.dm_hadr_availability_replica_cluster_nodes
