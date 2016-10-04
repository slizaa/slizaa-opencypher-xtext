package org.slizaa.neo4j.opencypher.tests

import org.junit.Test

class Constraint_Test extends AbstractCypherTest {

	@Test
	def void createUniquenessConstraint() {
		test('''
			CREATE CONSTRAINT ON (book:Book) ASSERT book.isbn IS UNIQUE
		''');
	}

	@Test
	def void dropUniquenessConstraint() {
		test('''
			DROP CONSTRAINT ON (book:Book) ASSERT book.isbn IS UNIQUE
		''');
	}

	@Test
	def void createIndex() {
		test('''
			CREATE INDEX ON :Person(name)
		''');
	}

	@Test
	def void dropIndex() {
		test('''
			DROP INDEX ON :Person(name)
		''');
	}

	@Test
	def void createNodePropertyExistenceConstraint() {
		test('''
			CREATE CONSTRAINT ON (book:Book) ASSERT exists(book.isbn)
		''');
	}

	@Test
	def void dropNodePropertyExistenceConstraint() {
		test('''
			DROP CONSTRAINT ON (book:Book) ASSERT exists(book.isbn)
		''');
	}

	@Test
	def void createRelationshipPropertyExistenceConstraints() {
		test('''
			CREATE CONSTRAINT ON ()-[like:LIKED]-() ASSERT exists(like.day)
		''');
	}

	@Test
	def void dropRelationshipPropertyExistenceConstraints() {
		test('''
			DROP CONSTRAINT ON ()-[like:LIKED]-() ASSERT exists(like.day)
		''');
	}
}
