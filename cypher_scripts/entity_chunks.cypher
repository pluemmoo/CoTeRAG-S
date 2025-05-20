LOAD CSV WITH HEADERS FROM 'file:///combined_chunks_with_labels.csv' AS row
WITH row, apoc.convert.fromJsonList(row.chunks) AS chunkList  // Parse chunks as list

// Merge the entity node with its label type
MERGE (e:entity: $(row.label) {name: row.entity, type: row.label})

// Iterate over each chunk in chunkList and create relationships
FOREACH (chunkText IN chunkList |
  MERGE (c:Chunk {text: chunkText})
  MERGE (e)-[:HAS_CHUNK]->(c)
);