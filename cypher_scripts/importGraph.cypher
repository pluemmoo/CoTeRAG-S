// Clear existing data
MATCH (n) DETACH DELETE n;

// Create nodes dynamically based on type
LOAD CSV WITH HEADERS FROM 'file:///Final_rebel_triples_labels_large.csv' AS row
WITH row

// Create Subject Nodes
MERGE (s: entity: $(row.subject_label) {name: row.subject, type:row.subject_label})

// Create Object Nodes
MERGE (o: entity: $(row.object_label) {name: row.object, type:row.object_label})

// Create Relationships 
WITH s, o, row
CALL apoc.create.relationship(s, row.relationship, {name: row.relationship}, o) YIELD rel
RETURN COUNT(rel) AS RelationshipCount;



LOAD CSV WITH HEADERS FROM 'file:///combined_chunks_with_labels.csv' AS row1
WITH row1, apoc.convert.fromJsonList(row1.chunks) AS chunkList

// 1) Merge the same entity node from CSV #2
MERGE (e:entity: $(row1.label) {name: trim(toLower(row1.entity))})
// Optional: if you have a label column, set the type
ON CREATE SET e.type = row1.label

// 2) For each chunk in chunkList, create a Chunk node and connect
FOREACH (chunkText IN chunkList |
  MERGE (c:Chunk {text: chunkText})
  MERGE (e)-[:HAS_CHUNK]->(c)
);


SHOW INDEXES;
