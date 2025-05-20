MATCH (source:entity)-[r]->(target:entity)
WITH gds.graph.project(
  'myGraph',
  source,
  target,
  {},
  {undirectedRelationshipTypes: ['*']}
) as g
RETURN g.graphName AS graph, g.nodeCount AS nodes, g.relationshipCount AS rels

// 2⃣ Run Weakly Connected Components (WCC) and store results
CALL gds.wcc.write('myGraph', {writeProperty: 'componentId'});

// 3⃣ Ensure all nodes have the `filtered` property (prevents missing property issues)
MATCH (n:entity)
SET n.filtered = false;

// 4⃣ Filter nodes with components that have ≥ 5 members
MATCH (n:entity)
WHERE n.componentId IS NOT NULL
WITH n.componentId AS component, COLLECT(n) AS nodes
WHERE SIZE(nodes) >= 5
UNWIND nodes AS node
SET node.filtered = true;

// 6⃣ Project the filtered subgraph properly while keeping your desired formatting
MATCH (sourceNode:entity)-[r]->(targetNode:entity)
WHERE sourceNode.filtered = true AND targetNode.filtered = true
WITH sourceNode, targetNode  // Ensure only filtered nodes are passed
RETURN gds.graph.project(
  'filteredGraph',
  sourceNode,
  targetNode,
  {} ,
  {undirectedRelationshipTypes: ['*']}
) AS graph;