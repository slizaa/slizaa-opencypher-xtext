package org.slizaa.neo4j.opencypher.ui.contentassist

import com.google.inject.Inject
import org.eclipse.emf.ecore.EObject
import org.eclipse.jface.text.templates.ContextTypeRegistry
import org.eclipse.jface.text.templates.Template
import org.eclipse.jface.text.templates.TemplateContextType
import org.eclipse.jface.text.templates.persistence.TemplateStore
import org.eclipse.xtext.ui.editor.contentassist.ContentAssistContext
import org.eclipse.xtext.ui.editor.templates.ContextTypeIdHelper
import org.eclipse.xtext.ui.editor.templates.DefaultTemplateProposalProvider
import org.slizaa.neo4j.opencypher.openCypher.SingleQuery

class OpenCypherTemplateProposalProvider extends DefaultTemplateProposalProvider {

	private TemplateStore templateStore;

	@Inject
	new(TemplateStore templateStore, ContextTypeRegistry registry, ContextTypeIdHelper helper) {
		super(templateStore, registry, helper)

		this.templateStore = templateStore;
	}

//	override protected createTemplates(TemplateContext templateContext, ContentAssistContext context,
//		ITemplateAcceptor acceptor) {
//
//		println(dump(context.currentModel, ""))
//
//		val TemplateContextType contextType = templateContext.getContextType();
//		val Template[] templates = templateStore.getTemplates(contextType.getId());
//		for (Template template : templates) {
//			if (!acceptor.canAcceptMoreTemplates())
//				return;
//			if (validate(template, templateContext)) {
//				acceptor.accept(
//					createProposal(template, templateContext, context, getImage(template), getRelevance(template)));
//			}
//		}
//	}
	override protected getContextTypes(ContentAssistContext context) {
		val TemplateContextType[] check = super.getContextTypes(context)

//		if (context.currentModel instanceof SingleQuery) {
//
//			// here we have to implement the logic which clause can used and which not...
//			println(dump(context.currentModel, ""))
//			return #[];
//		}
//		else if (context.currentModel instanceof SingleQuery) {
//
//			// here we have to implement the logic which clause can used and which not...
//			println(dump(context.currentModel, ""))
//			return #[];
//		}

//		println("------------------------------------------");
//		println("currentModel with expected grammar element" + context.currentModel)
//		println("previousModel " + context.previousModel)
//		for (contextType : check) {
//			println(contextType.name + " - " + contextType.id)
//		}
//		println("----------------------------------")

		// new TemplateContextType[]{new XtextTemplateContextType() Match - de.gerdwuetherich.opencypher.OpenCypher.Match}
		// val XtextTemplateContextType c = new XtextTemplateContextType();
		// c.name = "Match"
		// c.id = "de.gerdwuetherich.opencypher.OpenCypher.Match"
		//
		// val TemplateContextType[] myArray = #[]
		// return myArray
		return check;
	}

	def static String dump(EObject mod_, String indent) {

		var res = indent + mod_.toString.replaceFirst('.*[.]impl[.](.*)Impl[^(]*', '$1 ')

		for (a : mod_.eCrossReferences)
			res += ' ->' + a.toString().replaceFirst('.*[.]impl[.](.*)Impl[^(]*', '$1 ')
		res += "\n"
		for (f : mod_.eContents) {
			res += f.dump(indent + "    ")
		}
		return res
	}

	override int getRelevance(Template template) {
		if (template.name.startsWith("match")) {
			10000;
		} else {
			super.getRelevance(template)
		}
	}
}
