
Select SoldToPartyId, CONCAT(B, C, F,I,K,M,N,O,S,T,V,Z) As Model From(
Select SoldToPartyId, Max(B) as B, Max(C) as C, Max(F) as F, MAx(I) as I, Max(K) as K, Max(M) as M, Max(N) as N, Max(O) as O, Max(S) as S, Max(T) as T, Max(V) as V, Max(Z) as Z From(
	SELECT SoldToPartyId, SupplyChainServModel, IIf(([SupplyChainServModel]='B'),'B',Null) AS B, IIf(([SupplyChainServModel]='C'),'C',Null) AS C, IIf(([SupplyChainServModel]='F'),'F',Null) AS F, IIf(([SupplyChainServModel]='I'),'I',Null) AS I, IIf(([SupplyChainServModel]='K'),'K',Null) AS K, IIf(([SupplyChainServModel]='M'),'M',Null) AS M, IIf(([SupplyChainServModel]='N'),'N',Null) AS N, IIf(([SupplyChainServModel]='O'),'O',Null) AS O, IIf(([SupplyChainServModel]='S'),'S',Null) AS S, IIf(([SupplyChainServModel]='T'),'T',Null) AS T, IIf(([SupplyChainServModel]='V'),'V',Null) AS V, IIf(([SupplyChainServModel]='Z'),'Z',Null) AS Z
	FROM ZtcCrmSupplySrv) as Models
Group by SoldToPartyId) As ModelsGrouped