CREATE TABLE parents AS
  SELECT "abraham" AS parent, "barack" AS child UNION
  SELECT "abraham"          , "clinton"         UNION
  SELECT "delano"           , "herbert"         UNION
  SELECT "fillmore"         , "abraham"         UNION
  SELECT "fillmore"         , "delano"          UNION
  SELECT "fillmore"         , "grover"          UNION
  SELECT "eisenhower"       , "fillmore";

CREATE TABLE dogs AS
  SELECT "abraham" AS name, "long" AS fur, 26 AS height UNION
  SELECT "barack"         , "short"      , 52           UNION
  SELECT "clinton"        , "long"       , 47           UNION
  SELECT "delano"         , "long"       , 46           UNION
  SELECT "eisenhower"     , "short"      , 35           UNION
  SELECT "fillmore"       , "curly"      , 32           UNION
  SELECT "grover"         , "short"      , 28           UNION
  SELECT "herbert"        , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;


-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT first.name AS name,second.size AS size FROM dogs AS first,sizes AS second 
  WHERE second.min<first.height AND second.max>first.height OR second.max=first.height;


-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS
  SELECT first.child FROM parents AS first,dogs AS second
  WHERE first.parent=second.name ORDER BY second.height DESC;


-- Filling out this helper table is optional
CREATE TABLE siblings AS
  SELECT first.child AS younger,second.child AS older FROM parents AS first,parents AS second
  WHERE first.parent=second.parent AND first.child<second.child;


-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  SELECT "The two siblings, " || first.younger ||" plus " || first.older || " have the same size: " || second.size
  FROM siblings AS first,size_of_dogs AS second WHERE first.younger=second.name 
  AND (SELECT tmp.size FROM size_of_dogs AS tmp WHERE first.younger=tmp.name)=
      (SELECT tmp.size FROM size_of_dogs AS tmp WHERE first.older=tmp.name);

