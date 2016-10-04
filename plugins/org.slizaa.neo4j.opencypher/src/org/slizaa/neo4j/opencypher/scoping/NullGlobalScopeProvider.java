package org.slizaa.neo4j.opencypher.scoping;

import org.eclipse.emf.ecore.EReference;
import org.eclipse.emf.ecore.resource.Resource;
import org.eclipse.xtext.resource.IEObjectDescription;
import org.eclipse.xtext.scoping.IGlobalScopeProvider;
import org.eclipse.xtext.scoping.IScope;

import com.google.common.base.Predicate;

public class NullGlobalScopeProvider implements IGlobalScopeProvider {

	@Override
	public IScope getScope(Resource context, EReference reference,
			Predicate<IEObjectDescription> filter) {
		return IScope.NULLSCOPE;
	}

}