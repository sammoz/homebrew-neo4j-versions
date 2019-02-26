# homebrew-neo4j-versions

Neo4J is a graph database (http://neo4j.org)

```brew neo4j``` formula doesn't support versioning and will always install the latest (committed) version.

This repostiory helps to restore older versions.

# Installing homebrew-neo4j-versions

Brew allows formula extension via taps (https://docs.brew.sh/Taps).

Add tap to brew

``` brew tap sammoz/neo4j-versions```
 
 Install Formula
 
 ```brew install neo4j-232```
 
 Run
 
 ```neo4j-232 start```
