CALL gds.leiden.write('filteredGraph', {
  writeProperty: 'leidenCommunity',
  gamma: 1
})
YIELD communityCount, modularity
RETURN communityCount, modularity

    
MATCH (n)
WHERE n.leidenCommunity IS NOT NULL
RETURN n.leidenCommunity AS community, count(*) AS nodesInCommunity
ORDER BY nodesInCommunity DESC


MATCH (n)-[r]-(m)
WHERE n.leidenCommunity IS NOT NULL AND m.leidenCommunity IS NOT NULL
RETURN n, r, m