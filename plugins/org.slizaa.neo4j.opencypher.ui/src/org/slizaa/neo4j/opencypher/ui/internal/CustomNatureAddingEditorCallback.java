package org.slizaa.neo4j.opencypher.ui.internal;

import org.eclipse.core.resources.IProject;
import org.eclipse.core.resources.IProjectDescription;
import org.eclipse.core.resources.IResource;
import org.eclipse.core.runtime.CoreException;
import org.eclipse.xtext.ui.XtextProjectHelper;
import org.eclipse.xtext.ui.editor.IXtextEditorCallback;
import org.eclipse.xtext.ui.editor.XtextEditor;

public class CustomNatureAddingEditorCallback extends IXtextEditorCallback.NullImpl {

  @Override
  public void afterCreatePartControl(XtextEditor editor) {

    IResource resource = editor.getResource();
    IProject project = resource.getProject();

    if (resource != null && !hasNature(resource.getProject()) && resource.getProject().isAccessible()
        && !resource.getProject().isHidden()) {

      try {

        IProjectDescription description = project.getDescription();
        String[] natures = description.getNatureIds();

        // Add the nature
        String[] newNatures = new String[natures.length + 1];
        System.arraycopy(natures, 0, newNatures, 0, natures.length);
        newNatures[natures.length] = XtextProjectHelper.NATURE_ID;
        description.setNatureIds(newNatures);
        project.setDescription(description, null);

      } catch (CoreException e) {
        // log.error("Error toggling Xtext nature", e);
      }
    }
  }

  public boolean hasNature(IProject project) {
    return XtextProjectHelper.hasNature(project);
  }
}