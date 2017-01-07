package org.slizaa.neo4j.opencypher.ui.util;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;

import org.eclipse.core.runtime.IAdapterFactory;
import org.eclipse.emf.common.util.URI;
import org.eclipse.emf.ecore.resource.Resource;
import org.eclipse.emf.ecore.resource.Resource.Diagnostic;
import org.eclipse.xtext.resource.XtextResource;
import org.eclipse.xtext.resource.XtextResourceSet;
import org.slizaa.neo4j.opencypher.openCypher.Cypher;

import com.google.inject.Inject;

/**
 * <p>
 * See:
 * http://coopology.com/2011/06/easily-load-xtext-files-and-objects-in-eclipse-plugin-or-rcp-projects-using-adapters/
 * </p>
 *
 * @author Gerd W&uuml;therich (gerd@gerd-wuetherich.de)
 */
@SuppressWarnings("rawtypes")
public class ModelLoadingAdapter implements IAdapterFactory {

  private static org.apache.log4j.Logger log   = org.apache.log4j.Logger.getLogger(ModelLoadingAdapter.class);

  @Inject
  private XtextResourceSet               _xtextResourceSet;

  private Resource                       _resource;

  /** - */
  private Object                         _lock = new Object();

  @Override
  public Object getAdapter(Object adaptableObject, Class adapterType) {

    if (adapterType == Cypher.class) {

      if (adaptableObject instanceof String) {

        synchronized (_lock) {
          //
          String query = (String) adaptableObject;
          if (query.startsWith("\"")) {
            query = query.substring(1);
          }
          if (query.endsWith("\"")) {
            query = query.substring(0, query.length() - 1);
          }
          if (_resource == null) {
            _xtextResourceSet.addLoadOption(XtextResource.OPTION_RESOLVE_ALL, Boolean.TRUE);
            _resource = _xtextResourceSet.createResource(URI.createURI("dummy:/example.cypher"));
          }
          _resource.unload();

          try (InputStream in = new ByteArrayInputStream(query.getBytes())) {
            _resource.load(in, _xtextResourceSet.getLoadOptions());
          } catch (IOException exception) {
            exception.printStackTrace();
            return null;
          }

          for (Diagnostic diagnostic : _resource.getErrors()) {
            System.out.println(diagnostic);
          }
          if (_resource.getErrors().size() > 0) {
            return null;
          }
          //
          Cypher model = (Cypher) _resource.getContents().get(0);
          return model;
        }
      }
    }

    return null;
  }

  @Override
  public Class[] getAdapterList() {
    return new Class[] { Cypher.class };
  }
}