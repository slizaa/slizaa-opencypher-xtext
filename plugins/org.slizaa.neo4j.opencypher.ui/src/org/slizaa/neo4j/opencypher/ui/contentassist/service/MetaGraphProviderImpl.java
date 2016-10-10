package org.slizaa.neo4j.opencypher.ui.contentassist.service;

public class MetaGraphProviderImpl implements IMetaGraphProvider {

  @Override
  public String[] getLabels() {
    
//    MATCH (n)
//    WITH DISTINCT labels(n) as labels
//    UNWIND labels as label
//    RETURN distinct label
//    ORDER BY label
    
    return new String[] { "ActivationOS", "Annotation", "Archive", "Array", "Artifact", "Attribute", "Class", "Concept",
        "Configuration", "Constructor", "Container", "Directory", "Document", "Element", "Enum", "ExecutionGoal",
        "Field", "File", "Interface", "Jar", "Java", "License", "Manifest", "ManifestEntry", "ManifestSection", "Maven",
        "Member", "Method", "Namespace", "Package", "Parameter", "Plugin", "PluginExecution", "Pom", "Primitive",
        "Profile", "ProfileActivation", "Project", "Properties", "Property", "ServiceLoader", "Text", "Type", "Value",
        "Xml", "Zip" };
  }
}
