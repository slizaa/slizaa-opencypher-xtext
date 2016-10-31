package org.slizaa.neo4j.opencypher.ui.custom.editor;

import org.eclipse.jface.resource.ImageDescriptor;
import org.eclipse.jface.resource.ImageRegistry;
import org.eclipse.swt.graphics.Image;
import org.slizaa.neo4j.opencypher.ui.internal.OpencypherActivator;

/**
 * This enumeration provides a number of images for the plug-in.
 */
public enum OpenCypherUiImages {

  /** - */
  EXECUTE_QUERY("icons/execute_query.gif");

  /** - */
  private final String _path;

  /**
   * <p>
   * Creates a new instance of type {@link OpenCypherUiImages}.
   * </p>
   *
   * @param path
   */
  private OpenCypherUiImages(final String path) {
    this._path = path;
  }

  /**
   * Returns an image. Clients do not need to dispose the image, it will be disposed automatically.
   * 
   * @return an {@link Image}
   */
  public Image getImage() {
    final ImageRegistry imageRegistry = OpencypherActivator.getInstance().getImageRegistry();
    Image image = imageRegistry.get(this._path);
    if (image == null) {
      addImageDescriptor();
      image = imageRegistry.get(this._path);
    }

    return image;
  }

  /**
   * <p>
   * </p>
   *
   * @return
   */
  public ImageDescriptor getImageDescriptor() {
    final ImageRegistry imageRegistry = OpencypherActivator.getInstance().getImageRegistry();
    ImageDescriptor imageDescriptor = imageRegistry.getDescriptor(this._path);
    if (imageDescriptor == null) {
      addImageDescriptor();
      imageDescriptor = imageRegistry.getDescriptor(this._path);
    }

    return imageDescriptor;
  }

  /**
   * <p>
   * </p>
   */
  private void addImageDescriptor() {
    final ImageDescriptor id = ImageDescriptor.createFromURL(OpencypherActivator.getInstance().getBundle().getEntry(this._path));
    OpencypherActivator.getInstance().getImageRegistry().put(this._path, id);
  }
}