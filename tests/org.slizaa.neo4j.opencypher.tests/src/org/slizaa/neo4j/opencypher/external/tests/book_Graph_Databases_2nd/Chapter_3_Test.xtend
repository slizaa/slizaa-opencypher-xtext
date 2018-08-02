package org.slizaa.neo4j.opencypher.external.tests.book_Graph_Databases_2nd

import org.junit.Test
import org.slizaa.neo4j.opencypher.tests.AbstractCypherTest

class Chapter_3_Test extends AbstractCypherTest {

	@Test
	def void example_29_1() {
		test('''
			MATCH (a:Person {name:'Jim'})-[:KNOWS]->(b)-[:KNOWS]->(c),
			(a)-[:KNOWS]->(c)
			RETURN b, c
		''');
	}

	@Test
	def void example_30_1() {
		test('''
			MATCH (a:Person)-[:KNOWS]->(b)-[:KNOWS]->(c), (a)-[:KNOWS]->(c)
			WHERE a.name = 'Jim'
			RETURN b, c
		''');
	}

	@Test
	def void example_40_1() {
		test('''
			MATCH (user:User)-[*1..5]-(asset:Asset)
			WHERE user.name = 'User 3' AND asset.status = 'down'
			RETURN DISTINCT asset
		''');
	}

	@Test
	def void example_45_1() {
		test('''
			CREATE (shakespeare:Author {firstname:'William', lastname:'Shakespeare'}),
			(juliusCaesar:Play {title:'Julius Caesar'}),
			(shakespeare)-[:WROTE_PLAY {year:1599}]->(juliusCaesar),
			(theTempest:Play {title:'The Tempest'}),
			(shakespeare)-[:WROTE_PLAY {year:1610}]->(theTempest),
			(rsc:Company {name:'RSC'}),
			(production1:Production {name:'Julius Caesar'}),
			(rsc)-[:PRODUCED]->(production1),
			(production1)-[:PRODUCTION_OF]->(juliusCaesar),
			(performance1:Performance {date:20120729}),
			(performance1)-[:PERFORMANCE_OF]->(production1),
			(production2:Production {name:'The Tempest'}),
			(rsc)-[:PRODUCED]->(production2),
			(production2)-[:PRODUCTION_OF]->(theTempest),
			(performance2:Performance {date:20061121}),
			(performance2)-[:PERFORMANCE_OF]->(production2),
			(performance3:Performance {date:20120730}),
			(performance3)-[:PERFORMANCE_OF]->(production1),
			(billy:User {name:'Billy'}),
			(review:Review {rating:5, review:'This was awesome!'}),
			(billy)-[:WROTE_REVIEW]->(review),
			(review)-[:RATED]->(performance1),
			(theatreRoyal:Venue {name:'Theatre Royal'}),
			(performance1)-[:VENUE]->(theatreRoyal),
			(performance2)-[:VENUE]->(theatreRoyal),
			(performance3)-[:VENUE]->(theatreRoyal),
			(greyStreet:Street {name:'Grey Street'}),
			(theatreRoyal)-[:STREET]->(greyStreet),
			(newcastle:City {name:'Newcastle'}),
			(greyStreet)-[:CITY]->(newcastle),
			(tyneAndWear:County {name:'Tyne and Wear'}),
			(newcastle)-[:COUNTY]->(tyneAndWear),
			(england:Country {name:'England'}),
			(tyneAndWear)-[:COUNTRY]->(england),
			(stratford:City {name:'Stratford upon Avon'}),
			(stratford)-[:COUNTRY]->(england),
			(rsc)-[:BASED_IN]->(stratford),
			(shakespeare)-[:BORN_IN]->(stratford)			
		''');
	}

	@Test
	def void example_47_2() {
		test('''
			CREATE INDEX ON :Venue(name)
		''');
	}

	@Test
	def void example_47_3() {
		test('''
			CREATE CONSTRAINT ON (c:Country) ASSERT c.name IS UNIQUE
		''');
	}

	@Test
	def void example_48_1() {
		test('''
			MATCH (theater:Venue {name:'Theatre Royal'}),
			(newcastle:City {name:'Newcastle'}),
			(bard:Author {lastname:'Shakespeare'}),
			(newcastle)<-[:STREET|CITY*1..2]-(theater)
			<-[:VENUE]-()-[:PERFORMANCE_OF]->()
			-[:PRODUCTION_OF]->(play)<-[:WROTE_PLAY]-(bard)
			RETURN DISTINCT play.title AS play
		''');
	}

	@Test
	def void example_50() {
		test('''
			MATCH (theater:Venue {name:'Theatre Royal'}),
			(newcastle:City {name:'Newcastle'}),
			(bard:Author {lastname:'Shakespeare'}),
			(newcastle)<-[:STREET|CITY*1..2]-(theater)
			<-[:VENUE]-()-[:PERFORMANCE_OF]->()
			-[:PRODUCTION_OF]->(play)<-[w:WROTE_PLAY]-(bard)
			WHERE w.year > 1608
			RETURN DISTINCT play.title AS play
		''');
	}

	@Test
	def void example_51() {
		test('''
			MATCH (bard:Author {lastname:'Shakespeare'})-[w:WROTE_PLAY]->(play)
			WITH play
			ORDER BY w.year DESC
			RETURN collect(play.title) AS plays
		''');
	}

	@Test
	def void example_53_1() {
		test('''
			CREATE (alice:User {username:'Alice'}),
			(bob:User {username:'Bob'}),
			(charlie:User {username:'Charlie'}),
			(davina:User {username:'Davina'}),
			(edward:User {username:'Edward'}),
			(alice)-[:ALIAS_OF]->(bob)
		''');
	}

	@Test
	def void example_53_2() {
		test('''
			MATCH (bob:User {username:'Bob'}),
			(charlie:User {username:'Charlie'}),
			(davina:User {username:'Davina'}),
			(edward:User {username:'Edward'})
			CREATE (bob)-[:EMAILED]->(charlie),
			(bob)-[:CC]->(davina),
			(bob)-[:BCC]->(edward)
		''');
	}

	@Test
	def void example_54() {
		test('''
			MATCH (bob:User {username:'Bob'})-[e:EMAILED]->
			(charlie:User {username:'Charlie'})
			RETURN e
		''');
	}

	@Test
	def void example_55_1() {
		test('''
			CREATE (bob)-[:EMAILED]->(charlie)
		''');
	}

	@Test
	def void example_55_2() {
		test('''
			CREATE (email_1:Email {id:'1', content:'Hi Charlie, ... Kind regards, Bob'}),
			(bob)-[:SENT]->(email_1),
			(email_1)-[:TO]->(charlie),
			(email_1)-[:CC]->(davina),
			(email_1)-[:CC]->(alice),
			(email_1)-[:BCC]->(edward)
		''');
	}

	@Test
	def void example_56() {
		test('''
			CREATE (email_1:Email {id:'1', content:'email contents'}),
			(bob)-[:SENT]->(email_1),
			(email_1)-[:TO]->(charlie),
			(email_1)-[:CC]->(davina),
			(email_1)-[:CC]->(alice),
			(email_1)-[:BCC]->(edward);
		''');
	}

	@Test
	def void example_58() {
		test('''
			MATCH (bob:User {username:'Bob'})-[:SENT]->(email)-[:CC]->(alias),
			(alias)-[:ALIAS_OF]->(bob)
			RETURN email.id
		''');
	}

	@Test
	def void example_59() {
		test('''
			MATCH (email:Email {id:'1234'})
			CREATE (alice)-[:REPLIED_TO]->(email)
			CREATE (davina)-[:FORWARDED]->(email)-[:TO]->(charlie)
		''');
	}

	@Test
	def void example_60() {
		test('''
			MATCH p=(email:Email {id:'6'})<-[:REPLY_TO*1..4]-(:Reply)<-[:SENT]-(replier)
			RETURN replier.username AS replier, length(p) - 1 AS depth
			ORDER BY depth
		''');
	}
}
